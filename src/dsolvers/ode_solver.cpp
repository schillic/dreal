/*********************************************************************
Author: Soonho Kong <soonhok@cs.cmu.edu>
        Sicun Gao <sicung@cs.cmu.edu>
        Edmund Clarke <emc@cs.cmu.edu>

dReal -- Copyright (C) 2013 - 2014, Soonho Kong, Sicun Gao, and Edmund Clarke

dReal is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

dReal is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with dReal. If not, see <http://www.gnu.org/licenses/>.
*********************************************************************/

#include <algorithm>
#include <chrono>
#include <iomanip>
#include <limits>
#include <map>
#include <math.h>
#include <sstream>
#include <string>
#include <time.h>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include "util/logging.h"
#include "dsolvers/ode_solver.h"
#include "util/string.h"
#include "../tools/spaceex/include/sspaceex_api.h"

using capd::C0Rect2Set;
using capd::IFunction;
using capd::IMap;
using capd::IOdeSolver;
using capd::ITimeMap;
using capd::IVector;
using capd::interval;
using std::chrono::duration_cast;
using std::chrono::high_resolution_clock;
using std::chrono::milliseconds;
using std::exception;
using std::find_if;
using std::get;
using std::map;
using std::max;
using std::min;
using std::numeric_limits;
using std::reverse;
using std::setw;
using std::stoi;
using std::stringstream;
using std::to_string;
using std::tuple;
using std::unordered_map;
using std::unordered_set;

namespace dreal {
static unsigned g_hit = 0;
static unsigned g_nohit = 0;

// TODO(christian) only for debugging purposes
static int g_SpaceExCalls = 0;

list<interval> split(interval const & i, unsigned n) {
    list<interval> ret;
    double lb = i.leftBound();
    double const rb = i.rightBound();
    double const width = rb - lb;
    double const step = width / n;
    for (unsigned i = 0; i < n - 1; i++) {
        ret.emplace_back(lb, min(lb + step, rb));
        lb += step;
    }
    if (lb < rb) {
        ret.emplace_back(lb, rb);
    }
    return ret;
}

ode_solver::ode_solver(SMTConfig& c,
                       Egraph & e,
                       Enode * const l_int,
                       vector<Enode*> const & invs,
                       unordered_map<Enode*, int> & enode_to_rp_id) :
    m_config(c),
    m_egraph(e),
    m_int(l_int),
    m_invs(invs),
    m_enode_to_rp_id(enode_to_rp_id),
    m_stepControl(c.nra_ODE_step),
    m_time(nullptr),
    m_trivial(false) {
    // Pick the right flow_map (var |-> ODE) using current mode
    m_mode = l_int->getCdr()->getCar()->getValue();
    m_time = l_int->getCdr()->getCdr()->getCdr()->getCar();
    string time_str = m_time->getCar()->getName();                       // i.e. "time_1"
    m_step = stoi(time_str.substr(time_str.find_last_of("_") + 1));      // i.e. 1
    string flow_step = (m_egraph.stepped_flows ? to_string(m_step) + "_" : "");

    unordered_map<string, Enode *> & flow_map = m_egraph.flow_maps[string("flow_") + flow_step  + to_string(m_mode)];
    Enode * var_list = l_int->getCdr()->getCdr()->getCdr()->getCdr();


    // Collect _0, _t variables from variable list in integral literal
    while (!var_list->isEnil()) {
        string name = var_list->getCar()->getCar()->getName();
        size_t second_ = name.find_last_of("_");
        size_t first_ = name.find_last_of("_", second_ - 1);
        string name_prefix, name_postfix;
        if (first_ == string::npos) {
            name_prefix = name.substr(0, second_);
            name_postfix = name.substr(second_);
        } else {
            name_prefix = name.substr(0, first_);
            name_postfix = name.substr(first_);
        }
        if (flow_map.find(name_prefix) == flow_map.end()) {
            cerr << name_prefix << " is not found in flow_map." << endl;
            assert(flow_map.find(name_prefix) != flow_map.end());
        }

        Enode * const rhs = flow_map[name_prefix];
        stringstream ss;
        rhs->print_infix(ss, true, name_postfix);
        Enode * const _0_var = var_list->getCar();
        Enode * const _t_var = var_list->getCdr()->getCar();
        if (rhs->isConstant() && rhs->getValue() == 0.0) {
            // If RHS of ODE == 0.0, we treat it as a parameter in CAPD
            m_0_pars.push_back(_0_var);
            m_t_pars.push_back(_t_var);
            m_par_list.push_back(name);
        } else {
            // Otherwise, we treat it as an ODE variable.
            m_0_vars.push_back(_0_var);
            m_t_vars.push_back(_t_var);
            m_var_list.push_back(name);
            m_fwd_ode_list.push_back(ss.str());
            if (ss.str()[0] == '-'){
                // Do not double negate
                m_bkwd_ode_list.push_back(ss.str().substr(1));
            } else{
                m_bkwd_ode_list.push_back("-" + ss.str());
            }
        }
        var_list = var_list->getCdr()->getCdr();
    }

    // join var_list to make diff_var, ode_list to diff_fun_forward
    string diff_var = "";
    if (!m_var_list.empty()) {
        diff_var = "var:" + join(m_var_list, ", ") + ";";
    } else {
        m_trivial = true;
    }
    string diff_fun_forward = "";
    string diff_fun_backward = "";
    if (!m_fwd_ode_list.empty()) {
        diff_fun_forward = "fun:" + join(m_fwd_ode_list, ", ") + ";";
        diff_fun_backward = "fun:" + join(m_bkwd_ode_list, ", ") + ";";
    }
    // construct diff_sys_forward (string to CAPD)
    string diff_par;
    if (m_par_list.size() > 0) {
        diff_par = "par:" + join(m_par_list, ", ") + ";";
        m_diff_sys_forward = diff_par;
        m_diff_sys_backward = diff_par;
    }
    m_diff_sys_forward  += diff_var + diff_fun_forward;
    m_diff_sys_backward += diff_var + diff_fun_backward;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_par          : " << diff_par;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_var          : " << diff_var;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_fun_forward  : " << diff_fun_forward;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_fun_backward : " << diff_fun_backward;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_sys_forward  : " << m_diff_sys_forward;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_sys_backward : " << m_diff_sys_backward;
    for (auto ode_str : m_fwd_ode_list) {
        string const func_str = diff_par + diff_var + "fun:" + ode_str + ";";
        DREAL_LOG_INFO << "ode_solver::ode_solver: func = " << func_str;
        m_funcs.push_back(IFunction(func_str));
    };
    m_inv = extract_invariants();
}

// constructor with holder to flow map
ode_solver::ode_solver(SMTConfig& c,
                       Egraph & e,
                       Enode * const l_pint,
                       unordered_map<int, int> hfmap, // holder to flow map
                       vector<Enode*> const & invs,
                       unordered_map<Enode*, int> & enode_to_rp_id) :
    m_config(c),
    m_egraph(e),
    m_int(l_pint),
    m_invs(invs),
    m_enode_to_rp_id(enode_to_rp_id),
    m_stepControl(c.nra_ODE_step),
    m_time(nullptr),
    m_trivial(false) {
    Enode * head = l_pint->getCdr();
    vector<int> flow_list;

    cout << "initial";
    head->print(cout);

    head->getCar()->print(cout);
    cout << head->getCar()->isHolder;

    cout << "break0";

    // move head through all holders
    while (head->getCar()->isHolder) {
        cout << "in the loop";
        flow_list.push_back(hfmap[head->getCar()->getValue()]);
        cout<< head->getCar()->getValue();
        head = head -> getCdr();
    }

    cout << "above should be holder numbers.";
    // m_mode = l_pint->getCdr()->getCar()->getValue();
    m_time = head->getCdr()->getCar(); // this is only getting time_t ...|time(0.0)|time_t|vars|tail|
    string time_str = m_time->getCar()->getName();                       // i.e. "time_1"

    cout << time_str;

    m_step = stoi(time_str.substr(time_str.find_last_of("_") + 1));      // i.e. 1

    string flow_step = (m_egraph.stepped_flows ? to_string(m_step) + "_" : "");

    unordered_map<string, Enode *> flow_map;

    for (unsigned i = 0; i < flow_list.size(); i++) {
        unordered_map<string, Enode *> const &
            single_flow = m_egraph.flow_maps[string("flow_")
                                             + flow_step  + to_string(flow_list[i])];

        for (auto const & single_equation : single_flow) {
            flow_map[single_equation.first] = single_equation.second;
        }
    } // flow_map should collect a complete set of equations now

    cout << "break1";

    // next, collect vars
    Enode * var_list = head->getCdr()->getCdr();

    // Collect _0, _t variables from variable list in integral literal
    while (!var_list->isEnil()) {
        string name = var_list->getCar()->getCar()->getName();
        size_t second_ = name.find_last_of("_");
        size_t first_ = name.find_last_of("_", second_ - 1);

        cout << name;

        string name_prefix, name_postfix;
        if (first_ == string::npos) {
            name_prefix = name.substr(0, second_);
            name_postfix = name.substr(second_);
        } else {
            name_prefix = name.substr(0, first_);
            name_postfix = name.substr(first_);
        }
        if (flow_map.find(name_prefix) == flow_map.end()) {
            cerr << name_prefix << " is not found in flow_map." << endl;
            assert(flow_map.find(name_prefix) != flow_map.end());
        }
        cout << "break3";

        Enode * const rhs = flow_map[name_prefix];
        stringstream ss;
        rhs->print_infix(ss, true, name_postfix);
        Enode * const _0_var = var_list->getCar();
        Enode * const _t_var = var_list->getCdr()->getCar();
        if (rhs->isConstant() && rhs->getValue() == 0.0) {
            // If RHS of ODE == 0.0, we treat it as a parameter in CAPD
            m_0_pars.push_back(_0_var);
            m_t_pars.push_back(_t_var);
            m_par_list.push_back(name);
        } else {
            // Otherwise, we treat it as an ODE variable.
            m_0_vars.push_back(_0_var);
            m_t_vars.push_back(_t_var);
            m_var_list.push_back(name);
            m_fwd_ode_list.push_back(ss.str());
            if (ss.str()[0] == '-'){
                // Do not double negate
                m_bkwd_ode_list.push_back(ss.str().substr(1));
            } else{
                m_bkwd_ode_list.push_back("-" + ss.str());
            }
        }
        var_list = var_list->getCdr()->getCdr();
    }

    cout << "break2";

    // join var_list to make diff_var, ode_list to diff_fun_forward
    string diff_var = "";
    if (!m_var_list.empty()) {
        diff_var = "var:" + join(m_var_list, ", ") + ";";
    } else {
        m_trivial = true;
    }
    string diff_fun_forward = "";
    string diff_fun_backward = "";
    if (!m_fwd_ode_list.empty()) {
        diff_fun_forward = "fun:" + join(m_fwd_ode_list, ", ") + ";";
        diff_fun_backward = "fun:" + join(m_bkwd_ode_list, ", ") + ";";
    }
    // construct diff_sys_forward (string to CAPD)
    string diff_par;
    if (m_par_list.size() > 0) {
        diff_par = "par:" + join(m_par_list, ", ") + ";";
        m_diff_sys_forward = diff_par;
        m_diff_sys_backward = diff_par;
    }
    m_diff_sys_forward  += diff_var + diff_fun_forward;
    m_diff_sys_backward += diff_var + diff_fun_backward;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_par          : " << diff_par;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_var          : " << diff_var;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_fun_forward  : " << diff_fun_forward;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_fun_backward : " << diff_fun_backward;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_sys_forward  : " << m_diff_sys_forward;
    DREAL_LOG_INFO << "ode_solver::ode_solver: diff_sys_backward : " << m_diff_sys_backward;
    for (auto ode_str : m_fwd_ode_list) {
        string const func_str = diff_par + diff_var + "fun:" + ode_str + ";";
        DREAL_LOG_INFO << "ode_solver::ode_solver: func = " << func_str;
        m_funcs.push_back(IFunction(func_str));
    };
    m_inv = extract_invariants();
}

ode_solver::~ode_solver() {
}

void ode_solver::update(rp_box b) {
    m_b = b;
    m_X_0 = varlist_to_IVector(m_0_vars);
    m_X_t = varlist_to_IVector(m_t_vars);
    m_T = interval(get_lb(m_time), get_ub(m_time));
}


void ode_solver::print_datapoint(ostream& out, interval const & t, interval const & v) const {
    out << "{ " << "\"time\": " << t << ", " << "\"enclosure\": " << v << "}";
}

void ode_solver::print_trace(ostream& out,
                             string const & key,
                             int const idx,
                             list<pair<interval, IVector>> const & trajectory) const {
    out << "{" << endl;
    out << "\t" << "\"key\": \"" << key << "\"," << endl;
    out << "\t" << "\"mode\": \"" << m_mode << "\"," << endl;
    out << "\t" << "\"step\": \"" << m_step << "\"," << endl;
    out << "\t" << "\"values\": [" << endl;
    if (!trajectory.empty()) {
        auto iter = trajectory.cbegin();
        print_datapoint(out, iter->first, iter->second[idx]);
        for (++iter; iter != trajectory.cend(); iter++) {
            out << ", " << endl;
            print_datapoint(out, iter->first, iter->second[idx]);
        }
        out << endl;
    }
    out << "\t" << "]" << endl;
    out << "}" << endl;
}

void ode_solver::print_trajectory(ostream& out) const {
    out.precision(12);
    out << "[" << endl;
    if (!m_var_list.empty()) {
        print_trace(out, m_var_list[0], 0, m_trajectory);
        for (size_t i = 1; i < m_var_list.size(); i++) {
            out << ", " << endl;
            print_trace(out, m_var_list[i], i, m_trajectory);
        }
    }
    out << endl << "]" << endl;
}

void ode_solver::prune_trajectory(interval& time, IVector& e) {
    // Remove datapoints after time interval.
    auto ite = find_if (m_trajectory.begin(),
                        m_trajectory.end(),
                        [&time](pair<interval, IVector>& item) {
                            return item.first.leftBound() > time.rightBound();
                        });
    m_trajectory.erase(ite, m_trajectory.end());

    // Update the datapoints in the time interval
    ite = find_if (m_trajectory.begin(), m_trajectory.end(), [&time](pair<interval, IVector>& item) {
            return item.first.leftBound()>= time.leftBound();
        });
    for_each(ite, m_trajectory.end(), [&e](pair<interval, IVector>& item) {
            intersection(item.second, e, item.second);
        });
}

IVector ode_solver::varlist_to_IVector(vector<Enode*> const & vars) {
    IVector intvs (vars.size());
    /* Assign current interval values */
    for (unsigned i = 0; i < vars.size(); i++) {
        Enode* const & var = vars[i];
        interval & intv = intvs[i];
        double lb = get_lb(var);
        double ub = get_ub(var);
        intv = interval(lb, ub);
        DREAL_LOG_INFO << "ode_solver::varlist_to_IVector: The interval on " << var->getCar()->getName() << ": " << intv;
    }
    return intvs;
}

IVector ode_solver::extract_invariants() {
    unordered_map<Enode*, pair<double, double>> inv_map;
    for (auto inv : m_invs) {
        Enode * p = inv->getCdr()->getCdr()->getCdr()->getCdr()->getCar();
        Enode * op = p->getCar();
        bool pos = true;

        // Handle Negation
        if (op->getId() == ENODE_ID_NOT) {
            p = p->getCdr()->getCar();
            op = p->getCar();
            pos = false;
        }
        switch (op->getId()) {
        case ENODE_ID_GEQ:
        case ENODE_ID_GT:
            // Handle >= & >
            pos = !pos;
        case ENODE_ID_LEQ:
        case ENODE_ID_LT: {
            // Handle <= & <
            Enode * lhs = pos ? p->getCdr()->getCar() : p->getCdr()->getCdr()->getCar();
            Enode * rhs = pos ? p->getCdr()->getCdr()->getCar() : p->getCdr()->getCar();
            if (lhs->isVar() && rhs->isConstant()) {
                if (inv_map.find(lhs) != inv_map.end()) {
                    inv_map[lhs].second = std::min(inv_map[lhs].second, rhs->getValue());
                } else {
                    inv_map.emplace(lhs, make_pair(lhs->getLowerBound(), rhs->getValue()));
                }
            } else if (lhs->isConstant() && rhs->isVar()) {
                if (inv_map.find(rhs) != inv_map.end()) {
                    inv_map[rhs].first = std::max(inv_map[rhs].first, lhs->getValue());
                } else {
                    inv_map.emplace(rhs, make_pair(lhs->getValue(), rhs->getUpperBound()));
                }
            } else {
                DREAL_LOG_ERROR << "ode_solver::extract_invariant: "
                                << "The provided invariant (" << p << ") is not of the form that we support.";
            }
        }
            break;
        default:
            DREAL_LOG_ERROR << "ode_solver::extract_invariant: "
                            << "The provided invariant (" << p << ") is not of the form that we support.";
        }
    }
    IVector ret (m_t_vars.size());
    unsigned i = 0;
    for (auto const & m_t_var : m_t_vars) {
        if (inv_map.find(m_t_var) != inv_map.end()) {
            auto inv = interval(inv_map[m_t_var].first, inv_map[m_t_var].second);
            DREAL_LOG_INFO << "ode_solver::extract_invariant: Invariant extracted from  " << m_t_var << " = " << inv;
            ret[i++] = inv;
        } else {
            auto inv = interval(m_t_var->getLowerBound(), m_t_var->getUpperBound());
            DREAL_LOG_INFO << "ode_solver::extract_invariant: Default Invariant set for " << m_t_var << " = " << inv;
            ret[i++] = inv;
        }
    }
    return ret;
}

void ode_solver::IVector_to_varlist(IVector const & v, vector<Enode*> & vars) {
    for (unsigned i = 0; i < v.dimension(); i++) {
        double lb = get_lb(vars[i]);
        double ub = get_ub(vars[i]);
        if (lb < v[i].leftBound())
            set_lb(vars[i], v[i].leftBound());
        if (ub > v[i].rightBound())
            set_ub(vars[i], v[i].rightBound());
    }
}

ode_solver::ODE_result ode_solver::simple_ODE(rp_box b, bool forward) {
    update(b);
    ODE_result ret = ODE_result::SAT;
    
    // Christian: use new pruning operators
    bool const USE_SPACEEX_FORWARD = true;
    bool const USE_FLOWSTAR_FORWARD = !USE_SPACEEX_FORWARD && true;
    bool const USE_SPACEEX_BACKWARD = true;
    bool const USE_FLOWSTAR_BACKWARD = !USE_SPACEEX_BACKWARD && true;
//     std::cerr << "--- new round ---" << std::endl;

    if (forward) {
        if (USE_SPACEEX_FORWARD) {
            ret = simple_ODE_SpaceEx_forward(m_X_0, m_X_t, m_T, m_inv);
        } else if (USE_FLOWSTAR_FORWARD) {
            ret = simple_ODE_FlowStar_forward(m_X_0, m_X_t, m_T, m_inv);
        } else {
            ret = simple_ODE_forward(m_X_0, m_X_t, m_T, m_inv, m_funcs);
        }
    } else {
        if (USE_SPACEEX_BACKWARD) {
            ret = simple_ODE_SpaceEx_backward(m_X_0, m_X_t, m_T, m_inv);
        } else if (USE_FLOWSTAR_BACKWARD) {
            ret = simple_ODE_FlowStar_backward(m_X_0, m_X_t, m_T, m_inv);
        } else {
            ret = simple_ODE_backward(m_X_0, m_X_t, m_T, m_inv, m_funcs);
        }
    }
    
    if (ret == ODE_result::UNSAT) {
        return ret;
    }

    if (forward) {
        if (USE_SPACEEX_BACKWARD) {
            return simple_ODE_SpaceEx_backward(m_X_0, m_X_t, m_T, m_inv);
        } else if (USE_FLOWSTAR_BACKWARD) {
            return simple_ODE_FlowStar_backward(m_X_0, m_X_t, m_T, m_inv);
        } else {
            return simple_ODE_backward(m_X_0, m_X_t, m_T, m_inv, m_funcs);
        }
    } else {
        if (USE_SPACEEX_FORWARD) {
            return simple_ODE_SpaceEx_forward(m_X_0, m_X_t, m_T, m_inv);
        } else if (USE_FLOWSTAR_FORWARD) {
            return simple_ODE_FlowStar_forward(m_X_0, m_X_t, m_T, m_inv);
        } else {
            return simple_ODE_forward(m_X_0, m_X_t, m_T, m_inv, m_funcs);
        }
    }
}

ode_solver::ODE_result ode_solver::solve_forward(rp_box b) {
    DREAL_LOG_INFO << "ode_solver::solve_forward";
    ODE_result ret = ODE_result::SAT;
    update(b);

    bool prune_params_result = prune_params();
    if (!prune_params_result) {
        return ODE_result::UNSAT;
    }

    static map<vector<double>, tuple<ODE_result, vector<pair<interval, IVector>>>> cache;
    vector<pair<interval, IVector>> bucket;

    if (m_config.nra_ODE_cache) {
        // Check Cache
        vector<double> currentX0T = extract_X0T(b);
        auto cache_it = cache.find(currentX0T);
        if (cache_it != cache.end()) {
            // HIT
            g_hit++;
            ODE_result cached_ret = get<0>(cache_it->second);
            if (cached_ret == ODE_result::UNSAT ||
                cached_ret == ODE_result::EXCEPTION ||
                cached_ret == ODE_result::TIMEOUT) {
                return cached_ret;
            }
            bucket = get<1>(cache_it->second);
        } else {
            // NoHit
            g_nohit++;
            // Compute
            ret = compute_forward(bucket);
            // Save to cache
            cache.emplace(currentX0T, make_tuple(ret, bucket));
        }
    } else {
        ret = compute_forward(bucket);
        DREAL_LOG_DEBUG << "ode_solver::compute_forward result = " << ret;
    }
    if (!m_trivial && (ret == ODE_result::SAT)) {
        return prune_forward(bucket);
    } else {
        return ret;
    }
}

ode_solver::ODE_result ode_solver::solve_backward(rp_box b) {
    DREAL_LOG_INFO << "ode_solver::solve_backward";
    ODE_result ret = ODE_result::SAT;
    update(b);

    bool prune_params_result = prune_params();
    if (!prune_params_result) {
        return ODE_result::UNSAT;
    }

    static map<vector<double>, tuple<ODE_result, vector<pair<interval, IVector>>>> cache;
    vector<pair<interval, IVector>> bucket;

    if (m_config.nra_ODE_cache) {
        // Check Cache
        vector<double> currentXtT = extract_XtT(b);
        auto cache_it = cache.find(currentXtT);
        if (cache_it != cache.end()) {
            // HIT
            g_hit++;
            ODE_result cached_ret = get<0>(cache_it->second);
            if (cached_ret == ODE_result::UNSAT ||
                cached_ret == ODE_result::EXCEPTION ||
                cached_ret == ODE_result::TIMEOUT) {
                return cached_ret;
            }
            bucket = get<1>(cache_it->second);
        } else {
            // NoHit
            g_nohit++;
            // Compute
            ret = compute_backward(bucket);
            // Save to cache
            cache.emplace(currentXtT, make_tuple(ret, bucket));
        }
    } else {
        DREAL_LOG_DEBUG << "ode_solver::compute_backward result = " << ret;
        ret = compute_backward(bucket);
    }
    if (!m_trivial && (ret == ODE_result::SAT)) {
        return prune_backward(bucket);
    } else {
        return ret;
    }
}

ode_solver::ODE_result ode_solver::compute_forward(vector<pair<interval, IVector>> & bucket) {
    DREAL_LOG_INFO << "ode_solver::compute_forward";
    ODE_result ret = ODE_result::SAT;
    auto start = high_resolution_clock::now();
    bool invariantViolated = false;
    if (m_trivial) { return ODE_result::SAT; }
    try {
        // Set up VectorField
        IMap vectorField(m_diff_sys_forward);
        set_params(vectorField);
        IOdeSolver solver(vectorField, m_config.nra_ODE_taylor_order);
        ITimeMap timeMap(solver);
        C0Rect2Set s(m_X_0);
        timeMap.stopAfterStep(true);

        // Control TimeStep
        // if (m_stepControl > 0) {
        //     timeMap.turnOffStepControl();
        //     solver.setStep(m_stepControl);
        // } else {
        //     solver.turnOnStepControl();
        // }

        // TODO(soonhok): visualization
        if (m_config.nra_json) {
            m_trajectory.clear();
            m_trajectory.emplace_back(timeMap.getCurrentTime(), IVector(s));
        }

        interval prevTime(0.);
        do {
            // Handle Timeout
            if (m_config.nra_ODE_timeout > 0.0) {
                auto end = high_resolution_clock::now();
                if (duration_cast<milliseconds>(end - start).count() >= m_config.nra_ODE_timeout) {
                    DREAL_LOG_INFO << "ode_solver::compute_forward: timeout";
                    return ODE_result::TIMEOUT;
                }
            }

            // Check Invariant
            invariantViolated = !check_invariant(s, m_inv);
            if (invariantViolated) {
                // TODO(soonhok): invariant
                if (timeMap.getCurrentTime().rightBound() < m_T.leftBound()) {
                    ret = ODE_result::UNSAT;
                } else {
                    ret = ODE_result::SAT;
                }
                break;
            }

            // Move s toward m_T.rightBound()
            timeMap(m_T.rightBound(), s);
            if (contain_NaN(s)) {
                DREAL_LOG_INFO << "ode_solver::compute_forward: contain NaN";
                return ODE_result::SAT;
            }

            if (m_T.leftBound() <= timeMap.getCurrentTime().rightBound()) {
                invariantViolated = inner_loop_forward(solver, prevTime, bucket);
                if (invariantViolated) {
                    // TODO(soonhok): invariant
                    DREAL_LOG_INFO << "ode_solver::compute_forward: invariant violated";
                    ret = ODE_result::SAT;
                    break;
                }
            } else {
                if (m_config.nra_json) {
                    interval const stepMade = solver.getStep();
                    const IOdeSolver::SolutionCurve& curve = solver.getCurve();
                    interval domain = interval(0, 1) * stepMade;
                    list<interval> intvs;
                    intvs = split(domain, m_config.nra_ODE_grid_size);
                    for (interval subsetOfDomain : intvs) {
                        interval dt = prevTime + subsetOfDomain;
                        IVector v = curve(subsetOfDomain);
                        m_trajectory.emplace_back(dt, v);
                    }
                }
                DREAL_LOG_INFO << "ode_solver::compute_forward:" << prevTime; // << "\t" << v;
            }
            prevTime = timeMap.getCurrentTime();
        } while (!invariantViolated && !timeMap.completed());
    } catch (exception& e) {
        DREAL_LOG_FATAL << "ode_solver::compute_forward: exception: " << e.what();
        ret = ODE_result::EXCEPTION;
    }
    if (m_config.nra_json) {
        prune_trajectory(m_T, m_X_t);
    }
    return ret;
}

ode_solver::ODE_result ode_solver::compute_backward(vector<pair<interval, IVector>> & bucket) {
    DREAL_LOG_INFO << "ode_solver::compute_backward";
    ODE_result ret = ODE_result::SAT;
    auto start = high_resolution_clock::now();
    bool invariantViolated = false;
    if (m_trivial) { return ODE_result::SAT; }
    try {
        // Set up VectorField
        IMap vectorField(m_diff_sys_backward);
        DREAL_LOG_DEBUG << "ode_solver::compute_backward() vectorField = " << m_diff_sys_backward;
        set_params(vectorField);
        IOdeSolver solver(vectorField, m_config.nra_ODE_taylor_order);
        ITimeMap timeMap(solver);
        C0Rect2Set s(m_X_t);
        timeMap.stopAfterStep(true);



        // Control TimeStep
        // if (m_stepControl > 0) {
        //     timeMap.turnOffStepControl();
        //     solver.setStep(m_stepControl);
        // } else {
        //     solver.turnOnStepControl();
        // }

        // TODO(soonhok): visualization
        // if (m_config.nra_json) {
        //     m_trajectory.clear();
        //     m_trajectory.emplace_back(m_T.rightBound() - timeMap.getCurrentTime(), IVector(s));
        // }

        interval prevTime(0.);
        do {
            // Handle Timeout
            if (m_config.nra_ODE_timeout > 0.0) {
                auto end = high_resolution_clock::now();
                if (duration_cast<milliseconds>(end - start).count() >= m_config.nra_ODE_timeout) {
                    DREAL_LOG_INFO << "ode_solver::compute_backward: timeout";
                    return ODE_result::TIMEOUT;
                }
            }

            // Check Invariant
            invariantViolated = !check_invariant(s, m_inv);
            if (invariantViolated) {
                // TODO(soonhok): invariant
                DREAL_LOG_INFO << "ode_solver::compute_backward: invariant violated";
                if (timeMap.getCurrentTime().rightBound() < m_T.leftBound()) {
                    ret = ODE_result::UNSAT;
                } else {
                    ret = ODE_result::SAT;
                }
                break;
            }

            // Move s toward m_T.rightBound()
            timeMap(m_T.rightBound(), s);
            if (contain_NaN(s)) {
                DREAL_LOG_INFO << "ode_solver::compute_backward: contain NaN";
                return ODE_result::SAT;
            }
            if (m_T.leftBound() <= timeMap.getCurrentTime().rightBound()) {
                invariantViolated = inner_loop_backward(solver, prevTime, bucket);
                if (invariantViolated) {
                    // TODO(soonhok): invariant
                    DREAL_LOG_INFO << "ode_solver::compute_backward: invariant violated";
                    ret = ODE_result::SAT;
                    break;
                }
            } else {
                DREAL_LOG_INFO << "ode_solver::compute_backward:" << prevTime << "\t"; // << v;
            }
            prevTime = timeMap.getCurrentTime();
        } while (!invariantViolated && !timeMap.completed());
    } catch (exception& e) {
        DREAL_LOG_FATAL << "ode_solver::compute_backward: exception: " << e.what();
        ret = ODE_result::EXCEPTION;
    }
    if (m_config.nra_json) {
        prune_trajectory(m_T, m_X_0);
    }
    return ret;
}

ode_solver::ODE_result ode_solver::prune_forward(vector<pair<interval, IVector>> & bucket) {
    // 1) Intersect each v in bucket with X_t.
    // 2) If there is no intersection in 1), set dt an empty interval [0, 0]
    for (pair<interval, IVector> & item : bucket) {
        interval & dt = item.first;
        IVector &  v  = item.second;
        // v = v union m_X_t
        if (!intersection(v, m_X_t, v)) {
            dt.setLeftBound(0.0);
            dt.setRightBound(0.0);
        }
    }
    bucket.erase(remove_if (bucket.begin(), bucket.end(),
                            [](pair<interval, IVector> const & item) {
                                interval const & dt = item.first;
                                return dt.leftBound() == 0.0 && dt.rightBound() == 0.0;
                            }),
                 bucket.end());
    if (bucket.empty()) {
        // UNSAT
        for (auto _t_var : m_t_vars) {
            set_empty_interval(_t_var);
        }
        set_empty_interval(m_time);
        return ODE_result::UNSAT;
    } else {
        m_T = bucket.begin()->first;
        m_X_t  = bucket.begin()->second;
        for (pair<interval, IVector> & item : bucket) {
            interval & dt = item.first;
            IVector &  v  = item.second;
            m_X_t  = intervalHull(m_X_t,  v);
            m_T    = intervalHull(m_T, dt);
        }
        IVector_to_varlist(m_X_t, m_t_vars);
        set_lb(m_time, m_T.leftBound());
        set_ub(m_time, m_T.rightBound());
        return ODE_result::SAT;
    }
}

ode_solver::ODE_result ode_solver::prune_backward(vector<pair<interval, IVector>> & bucket) {
    // 1) Intersect each v in bucket with X_0.
    // 2) If there is no intersection in 1), set dt an empty interval [0, 0]
    for (pair<interval, IVector> & item : bucket) {
        interval & dt = item.first;
        IVector &  v  = item.second;
        // v = v union m_X_t
        if (!intersection(v, m_X_0, v)) {
            dt.setLeftBound(0.0);
            dt.setRightBound(0.0);
        }
    }
    bucket.erase(remove_if (bucket.begin(), bucket.end(),
                            [](pair<interval, IVector> const & item) {
                                interval const & dt = item.first;
                                return dt.leftBound() == 0.0 && dt.rightBound() == 0.0;
                            }),
                 bucket.end());
    if (bucket.empty()) {
        // UNSAT
        for (auto _0_var : m_0_vars) {
            set_empty_interval(_0_var);
        }
        set_empty_interval(m_time);
        return ODE_result::UNSAT;
    } else {
        m_T = bucket.begin()->first;
        m_X_0  = bucket.begin()->second;
        for (pair<interval, IVector> & item : bucket) {
            interval & dt = item.first;
            IVector &  v  = item.second;
            m_X_0  = intervalHull(m_X_0,  v);
            m_T    = intervalHull(m_T, dt);
        }
        IVector_to_varlist(m_X_0, m_0_vars);
        set_lb(m_time, m_T.leftBound());
        set_ub(m_time, m_T.rightBound());
        return ODE_result::SAT;
    }
}

// Take an intersection of v and inv.
// If there is no intersection, return false.
bool ode_solver::check_invariant(IVector & v, IVector const & inv) {
    if (!intersection(v, inv, v)) {
        DREAL_LOG_INFO << "ode_solver::check_invariant: invariant violated!";
        for (unsigned i = 0; i < v.dimension(); i++) {
            if (v[i].leftBound() < inv[i].leftBound() || v[i].rightBound() > inv[i].rightBound()) {
                DREAL_LOG_INFO << "ode_solver::check_invariant: inv[" << i << "] = " << inv[i];
                DREAL_LOG_INFO << "ode_solver::check_invariant:   v[" << i << "] = " <<   v[i];
            }
        }
        return false;
    }
    return true;
}

bool ode_solver::check_invariant(C0Rect2Set & s, IVector const & inv) {
    IVector v(s);
    bool r = check_invariant(v, inv);
    s = C0Rect2Set(v);
    return r;
}

bool ode_solver::contain_NaN(IVector const & v) {
    for (interval const & i : v) {
        if (std::isnan(i.leftBound()) || std::isnan(i.rightBound())) {
            DREAL_LOG_INFO << "ode_solver::contain_Nan: NaN Found! : " << v;
            return true;
        }
    }
    return false;
}

bool ode_solver::contain_NaN(C0Rect2Set const & s) {
    return contain_NaN(IVector(s));
}

template<typename V>
bool ode_solver::union_and_join(vector<V> const & bucket, V & result) {
    // 1. u = Union of all the elements of bucket
    if (bucket.size() == 0) {
        DREAL_LOG_INFO << "ode_solver::union_and_join: nothing to collect from the bucket";
        return false;
    }
    V u = *(bucket.cbegin());
    for (auto ite = ++(bucket.cbegin()); ite != bucket.cend(); ite++) {
        DREAL_LOG_INFO << "ode_solver::union_and_join: U(" << u << ", " << *ite << ")";
        u = intervalHull(u, *ite);
        DREAL_LOG_INFO << "ode_solver::union_and_join: = " << u;
    }
    // 2. result = intersection(u, result);
    DREAL_LOG_INFO << "ode_solver::union_and_join: Intersect(" << u << ", " << result << ")";
    if (intersection(u, result, result)) {
        DREAL_LOG_INFO << "ode_solver::union_and_join: = " << result;
    } else {
        // intersection is empty!!
        DREAL_LOG_INFO << "ode_solver::union_and_join: = empty";
        return false;
    }
    return true;
}

// Run inner loop
// return true if it violates invariant otherwise return false.
bool ode_solver::inner_loop_forward(IOdeSolver & solver, interval const & prevTime, vector<pair<interval, IVector>> & bucket) {
    DREAL_LOG_INFO << "ode_solver::inner_loop_forward";

    interval const stepMade = solver.getStep();
    const IOdeSolver::SolutionCurve& curve = solver.getCurve();
    interval domain = interval(0, 1) * stepMade;
    list<interval> intvs;
    if (prevTime.rightBound() < m_T.leftBound()) {
        interval pre_T = interval(0, m_T.leftBound() - prevTime.rightBound());
        domain.setLeftBound(m_T.leftBound() - prevTime.rightBound());
        intvs = split(domain, m_config.nra_ODE_grid_size);
        intvs.push_front(pre_T);
    } else {
        intvs = split(domain, m_config.nra_ODE_grid_size);
    }

    for (interval subsetOfDomain : intvs) {
        interval dt = prevTime + subsetOfDomain;
        IVector v = curve(subsetOfDomain);
        if (!check_invariant(v, m_inv)) {
            // TODO(soonhok): invariant
            return true;
        }
        DREAL_LOG_INFO << "ode_solver::inner_loop_forward:" << dt << "\t" << v;
        if (prevTime + subsetOfDomain.rightBound() > m_T.leftBound()) {
            bucket.emplace_back(dt, v);
        }
        // TODO(soonhok): visualization
        if (m_config.nra_json) {
            m_trajectory.emplace_back(prevTime + subsetOfDomain, v);
        }
    }
    return false;
}

bool ode_solver::inner_loop_backward(IOdeSolver & solver, interval const & prevTime, vector<pair<interval, IVector>> & bucket) {
    interval const stepMade = solver.getStep();
    const IOdeSolver::SolutionCurve& curve = solver.getCurve();
    interval domain = interval(0, 1) * stepMade;
    list<interval> intvs;
    if (prevTime.rightBound() < m_T.leftBound()) {
        interval pre_T = interval(0, m_T.leftBound() - prevTime.rightBound());
        domain.setLeftBound(m_T.leftBound() - prevTime.rightBound());
        intvs = split(domain, m_config.nra_ODE_grid_size);
        intvs.push_front(pre_T);
    } else {
        intvs = split(domain, m_config.nra_ODE_grid_size);
    }

    for (interval subsetOfDomain : intvs) {
        interval dt = prevTime + subsetOfDomain;
        IVector v = curve(subsetOfDomain);
        if (!check_invariant(v, m_inv)) {
            // TODO(soonhok): invariant
            return true;
        }
        DREAL_LOG_INFO << "ode_solver::inner_loop_backward:" << dt << "\t" << v;
        if (prevTime + subsetOfDomain.rightBound() > m_T.leftBound()) {
            bucket.emplace_back(dt, v);
        }
        // TODO(soonhok): visualization
        // if (m_config.nra_json) {
        //     m_trajectory.emplace_back(m_T.rightBound() - (prevTime + subsetOfDomain), v);
        // }
    }
    return false;
}

bool ode_solver::prune_params() {
    for (unsigned i = 0; i < m_0_pars.size(); i++) {
        Enode * const _0_par = m_0_pars[i];
        Enode * const _t_par = m_t_pars[i];
        interval _0_intv = interval(get_lb(_0_par), get_ub(_0_par));
        interval const _t_intv = interval(get_lb(_t_par), get_ub(_t_par));
        DREAL_LOG_DEBUG << "ode_solver::prune_params _0_intv = " << _0_intv;
        DREAL_LOG_DEBUG << "ode_solver::prune_params _t_intv = " << _t_intv;
        if (!intersection(_0_intv, _t_intv, _0_intv)) {
            DREAL_LOG_DEBUG << "ode_solver::prune_params intersection = " << "empty";
            return false;
        } else {
            DREAL_LOG_DEBUG << "ode_solver::prune_params intersection = " << _0_intv;
            set_lb(_0_par, _0_intv.leftBound());
            set_ub(_0_par, _0_intv.rightBound());
            set_lb(_t_par, _0_intv.leftBound());
            set_ub(_t_par, _0_intv.rightBound());
        }
    }
    DREAL_LOG_DEBUG << "ode_solver::prune_params result = true";
    return true;
}

ode_solver::ODE_result ode_solver::simple_ODE_forward(IVector const & X_0, IVector & X_t, interval const & T,
                                                      IVector const & inv, vector<IFunction> & funcs) {
    bool prune_params_result = prune_params();
    if (!prune_params_result) {
        return ODE_result::UNSAT;
    }

    // X_t = X_t \cup (X_0 + (d/dt Inv) * T)
    for (unsigned i = 0; i < X_0.dimension(); i++) {
        interval const & x_0 = X_0[i];
        interval & x_t = X_t[i];
        IFunction & dxdt = funcs[i];
        set_params(dxdt);
        try {
            interval new_x_t = x_0 + dxdt(inv) * T;
            if (!intersection(new_x_t, x_t, x_t)) {
                DREAL_LOG_INFO << "ode_solver::simple_ODE_forward: no intersection for X_T => UNSAT";
                return ODE_result::UNSAT;
            }
        } catch (exception& e) {
            DREAL_LOG_FATAL << "ode_solver::simple_ODE_forward: Exception in Simple_ODE: " << e.what();
        }
    }
    // update
    IVector_to_varlist(X_t, m_t_vars);
    return ODE_result::SAT;
}

/* Christian: new SpaceEx function for forward pruning */
ode_solver::ODE_result ode_solver::simple_ODE_SpaceEx_forward(IVector const & X_0, IVector & X_t,
                                                              interval & T, IVector const & inv) {
//     std::cerr << std::endl << "-- forward pruning --" << std::endl;
//     std::cerr << X_0 << ", " << X_t << ", " << T << std::endl;
    ode_solver::ODE_result res = simple_ODE_SpaceEx_general(X_0, X_t, T, inv, true);
//     ode_solver::ODE_result res = simple_ODE_SpaceEx_general_files(X_0, X_t, T, inv, true);
//     std::cerr << X_0 << ", " << X_t << ", " << T << std::endl;
//     std::cerr << "res = " << res << std::endl;
    return res;
}

/* Christian: new SpaceEx function for backward pruning
 * The only differences to forward pruning are:
 * - we start in X_t
 * - we invert the dynamics by multiplying by -1
 * - we refine X_0
 */
ode_solver::ODE_result ode_solver::simple_ODE_SpaceEx_backward(IVector & X_0, IVector const & X_t,
                                                              interval & T, IVector const & inv) {
//     std::cerr << std::endl << "-- backward pruning --" << std::endl;
//     std::cerr << X_0 << ", " << X_t << ", " << T << std::endl;
    ode_solver::ODE_result res = simple_ODE_SpaceEx_general(X_t, X_0, T, inv, false);
//     ode_solver::ODE_result res = simple_ODE_SpaceEx_general_files(X_t, X_0, T, inv, false);
//     std::cerr << X_0 << ", " << X_t << ", " << T << std::endl;
//     std::cerr << "res = " << res << std::endl;
    return res;
}

/* Christian: new SpaceEx function for pruning (general) */
ode_solver::ODE_result ode_solver::simple_ODE_SpaceEx_general(IVector const & X_0,
            IVector & X_t, interval & T, IVector const & inv, bool const forward) {
    bool const prune_params_result = prune_params();
    if (!prune_params_result) {
        return ODE_result::UNSAT;
    }
    
    // switch here for library or binary mode
    bool const IS_LIBRARY_MODE = true;
    
    int const NUM_VAR = X_0.dimension();
    string const TIME_VAR = m_time->getCar()->getName();

    // mapping from variable name to ODE
    string const flow_step = (m_egraph.stepped_flows ? to_string(m_step) + "_" : "");
    unordered_map<string, Enode *> & flow_map = m_egraph.flow_maps[string("flow_") + flow_step + to_string(m_mode)];

    // mapping from variable index to name
    string * const index2varName = new string[NUM_VAR];
    Enode * var_list = m_int->getCdr()->getCdr()->getCdr()->getCdr();
    int index = 0;
    while (!var_list->isEnil()) {
        string const name = getVarName(var_list);
        index2varName[index] = name;
        
        // continue in list
        var_list = var_list->getCdr()->getCdr();
        ++index;
    }
    
    // strings describing initial states, invariant, flow, and forbidden states
    string const initialString = getInitStringSpaceEx(X_0, index2varName, TIME_VAR);
    string const invString = getInvStringSpaceEx(inv, T, index2varName, TIME_VAR, !IS_LIBRARY_MODE);
    string const flowString = getFlowStringSpaceEx(flow_map, m_int->getCdr()->getCdr()->getCdr()->getCdr(),
                                            index2varName, TIME_VAR, forward, !IS_LIBRARY_MODE);
    string const forbiddenString = getForbiddenStringSpaceEx(T, TIME_VAR);

    //     std::cerr << "init: " << initialString << std::endl;
    //     std::cerr << "inv: " << invString << std::endl;
    //     std::cerr << "flow: " << flowString << std::endl;
    //     std::cerr << "forbidden: " << forbiddenString << std::endl;

    // computational error allowed by SpaceEx
    double const ERROR_BOUND = 0.0000000000001;
    
    // - support function scenario (LGG) related parameters: -
    
    // size of the time slices
    double const samplingTime = 0.01;
    
    /*
     * maximum time (philosophy: use max. time plus two more time slices to make
     * sure the last time slice is already violating the invariant)
     */
    double const timeHorizon = T.rightBound() + 2 * samplingTime;
    
    if (IS_LIBRARY_MODE) { // library mode
        // create struct with a location
        location loc;
        loc.invariant = invString.c_str();
        loc.flow = flowString.c_str();
        
        // convert initial string
        const char* initial = initialString.c_str();
        
        // create struct with output variables
        output_variables outputs;
        outputs.size = NUM_VAR + 1;
        const char** vars = new const char*[NUM_VAR + 1];
        for (int i = 0; i < NUM_VAR; ++i) {
            vars[i] = index2varName[i].c_str();
        }
        vars[NUM_VAR] = TIME_VAR.c_str();
        outputs.variables = vars;
        
        // create struct with result for SpaceEx
        spaceex_result result;
        spaceex_variable_valuation resvals[NUM_VAR + 1];
        result.variable_results = resvals;
        
        // set options
        set_time_horizon(timeHorizon);
        // TODO(christian) What should we set here? Parameterize function?
        set_sampling_time(samplingTime);
        
        // run SpaceEx
        continuous_post(loc, initial, outputs, result);
        
        // intersect with forbidden states (= time interval T)
        spaceex_result_value intersection_result;
        
        constraints_result intersection;
        char msg[20];
        spaceex_tribool is_not_empty = intersect_with_bad_state(forbiddenString.c_str(),
                                            result, intersection_result, msg, intersection);
        
        if (is_not_empty.unknown || (intersection_result != OK)) {
            DREAL_LOG_INFO << "ode_solver::simple_ODE_SpaceEx_general: unknown result due to SpaceEx";
            return ODE_result::EXCEPTION;
        } else if (! is_not_empty) {
            DREAL_LOG_INFO << "ode_solver::simple_ODE_SpaceEx_general: no intersection in SpaceEx => UNSAT";
            return ODE_result::UNSAT;
        }
        
        // convert SpaceEx constraints to intervals (use old intervals)
        interval intervals[NUM_VAR + 1];
        for (int i = 0; i < NUM_VAR; ++i) {
            intervals[i] = X_t[i];
//             std::cerr << index2varName[i] << ": " << intervals[i] << std::endl;
        }
//         std::cerr << TIME_VAR << ": " << T << std::endl;
        intervals[NUM_VAR] = T;
        for (unsigned i = 0; i < intersection.size; ++i) {
            linear_constraint lin_constraint = intersection.constraints[i];
//             std::cerr << lin_constraint.valuation_char << std::endl;
            
            // find respective variable index
            string varName(lin_constraint.variable_name);
            const int IDX = (i % 2 == 0 ? i / 2 : (i-1) / 2);
            unsigned const j =
                findVariable(varName, index2varName, TIME_VAR, IDX, NUM_VAR);
            
            switch (lin_constraint.sign) {
                case SIGN_GT: // x > c
                case SIGN_GE: // x >= c
                    intervals[j].setLeftBound(lin_constraint.value);
                    break;
                case SIGN_LT: // x < c
                case SIGN_LE: // x <= c
                    intervals[j].setRightBound(lin_constraint.value);
                    break;
                case SIGN_EQ: // x == c
                    intervals[j].setLeftBound(lin_constraint.value);
                    intervals[j].setRightBound(lin_constraint.value);
                    break;
                default:
                    DREAL_LOG_INFO << "ode_solver::simple_ODE_SpaceEx_general: Unknown sign";
                    return ODE_result::EXCEPTION;
            }
        }
        
        // refine intervals wrt. SpaceEx output
        for (int i = 0; i <= NUM_VAR; ++i) {
            // new interval
            interval const new_x_t = interval(intervals[i].leftBound() - ERROR_BOUND,
                                              intervals[i].rightBound() + ERROR_BOUND);
            
//             if (i == NUM_VAR) {
//                 std::cerr << TIME_VAR << " (new): " << new_x_t << std::endl;
//             } else {
//                 std::cerr << index2varName[i] << " (new): " << new_x_t << std::endl;
//             }
            
            // prune
            if (prune_result(X_t, T, new_x_t, i, forward) == ODE_result::UNSAT) {
                return ODE_result::UNSAT;
            }
        }
    } else { // binary mode
        // TODO(christian) debugging: additional counter to write new files for each call
        string const numberString = to_string(++g_SpaceExCalls);
        
        string const FILES_PATH = "spaceex/";
        string const MODEL_FILE_NAME = FILES_PATH + "model" + numberString + ".xml";
        string const CONFIG_FILE_NAME = FILES_PATH + "config" + numberString + ".cfg";
        string const OUTPUT_FILE_NAME = FILES_PATH + "output" + numberString + ".txt";
        string const SCREEN_FILE_NAME = FILES_PATH + "screen" + numberString + ".txt";
        
        // write a SpaceEx model file
        std::ofstream out(MODEL_FILE_NAME);
        out << "<?xml version=\"1.0\" encoding=\"utf-8\"?>" << endl <<
            "<sspaceex xmlns=\"http://www-verimag.imag.fr/xml-namespaces/sspaceex\" version=\"0.2\" math=\"SpaceEx\">" << endl <<
            "  <component id=\"system\">" << endl;
        for (int i = 0; i < NUM_VAR; ++i) {
            out << "    <param name=\"" << index2varName[i] <<
                    "\" type=\"real\" local=\"true\" d1=\"1\" d2=\"1\" dynamics=\"any\" />\"" << endl;
        }
        out << "    <param name=\"" << TIME_VAR <<
            "\" type=\"real\" local=\"true\" d1=\"1\" d2=\"1\" dynamics=\"any\" />\"" << endl;
        out << "    <location id=\"1\" name=\"loc1\" x=\"300.0\" y=\"300.0\" width=\"300.0\" height=\"300.0\">" << endl <<
            "      <invariant>" << invString << "</invariant>" << endl <<
            "      <flow>" << flowString << "</flow>" << endl <<
            "    </location>" << endl <<
            "  </component>" << endl <<
            "</sspaceex>" << endl;
        out.close();

        // write a SpaceEx config file
        out.open(CONFIG_FILE_NAME);
        out << "system = system" << endl <<
            "initially = " << initialString << endl <<
            "forbidden = " << forbiddenString << endl <<
            "scenario = supp" << endl <<
            "directions = box" << endl <<
            "iter-max = 1" << endl <<
            "sampling-time = " << to_string(samplingTime) << endl <<
            "time-horizon = " << to_string(timeHorizon) << endl <<
            "rel-err = 1e-12" << endl <<
            "abs-err = 1e-15" << endl <<
            "output-format = INTV" << endl;
        
        out << "output-variables = \"";
        for (int i = 0; i < NUM_VAR; ++i) {
            out << index2varName[i] << ",";
        }
        out << TIME_VAR << "\"" << endl;
        out.close();
        
        // call SpaceEx
        // TODO(christian) How should we set the path to SpaceEx?
        string callString = "spaceex -m " + MODEL_FILE_NAME +
                            " -g " + CONFIG_FILE_NAME +
                            " -o " + OUTPUT_FILE_NAME +
                            " -v D7 > " + SCREEN_FILE_NAME;
        system(callString.c_str());
        
        // open and parse output file
        std::ifstream in(OUTPUT_FILE_NAME);
        string line;
        int i = -3;
        while (getline(in, line)) {
            ++i;
            if (i < 0) {
                continue;
            }
            // one iteration per variable
            
            // split interval string
            
            int const varEnd = line.find(':', 8);
            int const start = varEnd + 3;
            int comma = line.find(',', start + 1);
            int const end = line.find(']', comma + 2);
            string lower(line.substr(start, comma - start));
            ++comma;
            string upper(line.substr(comma, end - comma));
            interval const new_x_t = interval(std::stod(lower) - ERROR_BOUND,
                                            std::stod(upper) + ERROR_BOUND);
            
            // find respective variable index
            string varName = line.substr(7, varEnd - 7);
            unsigned const j =
                findVariable(varName, index2varName, TIME_VAR, i, NUM_VAR);
            
            // prune
            if (prune_result(X_t, T, new_x_t, j, forward) == ODE_result::UNSAT) {
                in.close();
                return ODE_result::UNSAT;
            }
            
            // last variable ends the loop
            if (i == NUM_VAR) {
                break;
            }
        }
        in.close();
    }
//     std::cerr << std::endl;

    // update
    if (forward) {
        IVector_to_varlist(X_t, m_t_vars);
    } else {
        IVector_to_varlist(X_t, m_0_vars);
    }
    return ODE_result::SAT;
}

/* Christian: new FlowStar function for forward pruning */
ode_solver::ODE_result ode_solver::simple_ODE_FlowStar_forward(IVector const & X_0,
            IVector & X_t, interval & T, IVector const & inv) {
    bool const prune_params_result = prune_params();
    if (!prune_params_result) {
        return ODE_result::UNSAT;
    }
    
    bool const forward = true;
    
    int const NUM_VAR = X_0.dimension();
    
    // mapping from variable name to ODE
    string const flow_step = (m_egraph.stepped_flows ? to_string(m_step) + "_" : "");
    unordered_map<string, Enode *> & flow_map = m_egraph.flow_maps[string("flow_") + flow_step + to_string(m_mode)];
    
    // mapping from variable index to name
    string * const index2varName = new string[NUM_VAR];
    Enode * var_list = m_int->getCdr()->getCdr()->getCdr()->getCdr();
    int index = 0;
    while (!var_list->isEnil()) {
        string const name = getVarName(var_list);
        index2varName[index] = name;
        
        // continue in list
        var_list = var_list->getCdr()->getCdr();
        ++index;
    }
    
    // name of the output files
    string const OUTPUT_FILE_NAME = "output_flowstar";
    
    // input string for FlowStar
    string const flowStarString =
            getStringFlowStar(X_0, T, inv, flow_map,
                              m_int->getCdr()->getCdr()->getCdr()->getCdr(),
                              index2varName, true, OUTPUT_FILE_NAME);
    
    // run FlowStar
    // TODO(christian) make this platform independent
    string callString = "flowstar <<< " + flowStarString + " > /dev/null";
//     std::cerr << callString << std::endl;
    system(callString.c_str());
    
    // TODO(christian) this should be replaced by a dynamic condition checked in the loop (but how?)
    bool IS_INTERESTING_FLOWPIPE = true;
    
    // union interval
    interval intervals[NUM_VAR];
    for (int i = 0; i < NUM_VAR; ++i) {
        intervals[i] = X_t[i];
//         std::cerr << index2varName[i] << ": " << intervals[i] << std::endl;
    }
    
    // open and parse output file
    std::ifstream in("intervals/" + OUTPUT_FILE_NAME + ".flow");
    string line;
    int i = -4;
    while (getline(in, line)) {
        ++i;
        if (i < 0) {
            continue;
        }
        
        // skip over non-interesting flowpipes
        if (! IS_INTERESTING_FLOWPIPE) {
            i = -4 - NUM_VAR;
            continue;
        }
        
        // terminate when an empty line was found
        if (! line.length()) {
            break;
        }
        
        // for one flowpipe get the values of variable xi
        int const varEnd = line.find(':', 1);
        int const start = varEnd + 3;
        int comma = line.find(',', start + 2);
        int const end = line.find(']', comma + 3);
        string lower(line.substr(start, comma - start - 1));
        string upper(line.substr(comma + 2, end - comma - 2));
        
        double const lowerD = std::stod(lower); // - ERROR_BOUND;
        double const upperD = std::stod(upper); // + ERROR_BOUND;
        
        string varName = line.substr(0, varEnd);
        unsigned const j = findVariable(varName, index2varName, "", i, NUM_VAR);
        
        interval & unionIntv = intervals[j];
//         std::cerr << varName << ": [" << lowerD << ", " << upperD << "]" << std::endl;
//         std::cerr << "old: " << unionIntv << std::endl;
        if (lowerD < unionIntv.leftBound()) {
//             std::cerr << "refining lower bound" << std::endl;
            unionIntv.setLeftBound(lowerD);
        }
        if (upperD > unionIntv.rightBound()) {
//             std::cerr << "refining upper bound" << std::endl;
            unionIntv.setRightBound(upperD);
        }
//         std::cerr << "new: " << unionIntv << std::endl;
        
        // skip over remaining lines after last variable
        if (i == NUM_VAR - 1) {
            i = -4;
        }
    }
    in.close();
    
    // prune intervals
    for (int i = 0; i < NUM_VAR; ++i) {
//         std::cerr << "final " + index2varName[i] + ": " << intervals[i] << std::endl;
        interval const new_x_t = intervals[i];
        
        // prune
        if (prune_result(X_t, T, new_x_t, i, forward) == ODE_result::UNSAT) {
            return ODE_result::UNSAT;
        }
    }
    
    // update
    if (forward) {
        IVector_to_varlist(X_t, m_t_vars);
    } else {
        IVector_to_varlist(X_t, m_0_vars);
    }
    return ODE_result::SAT;
}

/* Christian: new FlowStar function for backward pruning */
ode_solver::ODE_result ode_solver::simple_ODE_FlowStar_backward(IVector const & X_0,
            IVector & X_t, interval & T, IVector const & inv) {
    // TODO(christian) Write this function
    return ODE_result::EXCEPTION;
}

/* Christian: new function to find a given 
variable in the variables array */
unsigned ode_solver::findVariable(string & name, string * const index2varName,
                                  string const & TIME_VAR, int const IDX,
                                  int const NUM_VAR) {
    /*
     * There is an input index to give a priority (often the output order is the
     * input order). We check this first to possibly skip the full search.
     * However, it is not guaranteed that this always succeeds.
     * 
     * We know the input index is always in the interval [0, NUM_VAR].
     */
    if (IDX < NUM_VAR) {
        if (! name.compare(index2varName[IDX])) {
            return IDX;
        }
    } else {
        if (! name.compare(TIME_VAR)) {
            return IDX;
        }
    }
    
    // variable index is not the one from the input order, so find it
//     std::cerr << "variable was not found at first guess" << std::endl;
    for (int i = 0; i < NUM_VAR; ++i) {
        if (! name.compare(index2varName[i])) {
            return i;
        }
    }
    if (! name.compare(TIME_VAR)) {
        return NUM_VAR;
    }
    
    // NOTE: this should not happen
    DREAL_LOG_INFO << "ode_solver::findVariable: The variable does not exist.";
    return -1;
}

/* Christian: new function for actually pruning, given a result from an external solver */
ode_solver::ODE_result ode_solver::prune_result(IVector & X, interval & T,
                interval const & new_x, unsigned const i, bool const forward) {
    if (i == X.dimension()) {
        // time variable pruning = intersection of old with new interval
        if (forward) {
            if (!intersection(new_x, T, T)) {
                DREAL_LOG_INFO << "ode_solver::prune_result: no intersection for T => UNSAT";
                return ODE_result::UNSAT;
            }
        }
    } else {
        // state variable pruning = intersection of old with new interval
        interval & x = X[i];
        
        if (!intersection(new_x, x, x)) {
            DREAL_LOG_INFO << "ode_solver::prune_result: no intersection for X => UNSAT";
            return ODE_result::UNSAT;
        }
    }
    return ODE_result::SAT;
}

/* Christian: new function for printing SpaceEx initial states string */
string ode_solver::getInitStringSpaceEx(IVector const & X_0, string * const index2varName,
                                 string const timeString) {
    string str = "";
    
    // bounds for each variable
    for (unsigned i = 0; i < X_0.dimension(); i++) {
        interval const & x_0 = X_0[i];
        if (i > 0) {
             str += " & ";
        }
        str += to_string(x_0.leftBound()) + " <= " + 
                index2varName[i] + " <= " + to_string(x_0.rightBound());
    }
    
    // add initial time point
    if (timeString.length() > 0) {
        str += " & " + timeString + " == 0";
    }
    
    return str;
}

/* Christian: new function for printing SpaceEx invariant string */
string ode_solver::getInvStringSpaceEx(IVector const & inv, interval const & T,
                                string * const index2varName, string const timeString,
                                bool const FILE) {
    string const AND = (FILE ? " &amp; " : " & ");
    string const LTE = (FILE ? " &lt;= " : " <= ");
    string str = "";
    
    // bounds for each variable
    for (unsigned i = 0; i < inv.dimension(); i++) {
        interval const & x = inv[i];
        if (i > 0) {
             str += AND;
        }
        str += to_string(x.leftBound()) + LTE + index2varName[i] +
                    LTE + to_string(x.rightBound());
    }
    
    // add time bound
    if (timeString.length() > 0) {
        str += AND + timeString + LTE + to_string(T.rightBound());
    }
    
    return str;
}

/* Christian: new function for printing SpaceEx flow string */
string ode_solver::getFlowStringSpaceEx(unordered_map<string, Enode *> & flow_map, Enode * var_list,
                                 string * const index2varName, string const timeString,
                                 bool const forward_dynamics, bool const FILE) {
    string const AND = (FILE ? " &amp; " : " & ");
    string str = "";
    
    // get flow for each variable
    int i = 0;
    while (!var_list->isEnil()) {
        string name = index2varName[i];
        stringstream ss;
        Enode * const func = flow_map[name];
        func->print_infix(ss, true, "");
        
        // add next flow conjunct
        if (i > 0) {
             str += AND;
        }
        if (forward_dynamics) {
            str += name + "' == " + ss.str();
        } else {
            str += name + "' == " + "-(" + ss.str() + ")";
        }
        
        // continue in list
        var_list = var_list->getCdr()->getCdr();
        ++i;
    }
    
    // add time flow
    if (timeString.length() > 0) {
        str += AND + timeString + "' == 1";
    }
    
    return str;
}

/* Christian: new function for printing SpaceEx forbidden states string */
string ode_solver::getForbiddenStringSpaceEx(interval const & T, string const timeString) {
    return timeString + " >= " + to_string(T.leftBound());
}

/* Christian: new function for extracting the variable name */
string ode_solver::getVarName(Enode * var_list) {
    string name = var_list->getCar()->getCar()->getName();
    size_t second_ = name.find_last_of("_");
    size_t first_ = name.find_last_of("_", second_ - 1);
    string name_prefix;
    if (first_ == string::npos) {
        name_prefix = name.substr(0, second_);
    } else {
        name_prefix = name.substr(0, first_);
    }
    return name_prefix;
}

/* Christian: new function for printing FlowStar input string */
string ode_solver::getStringFlowStar(IVector const & X_0, interval const & T,
                                     IVector const & inv,
                                     unordered_map<string, Enode *> & flow_map,
                                     Enode * var_list,
                                     string * const index2varName,
                                     bool const forward_dynamics,
                                     string const outputFileName) {
    // TODO(christian) How should we set these options intelligently?
    int const opt_ode_mode = 1;
    double const opt_steps_l = 1.0;
    double const opt_steps_r = 1.0;
    string const opt_remainder = "1e-5";
    string const opt_precondition = ((X_0.dimension() > 3) ? "identity" : "QR"); // TODO(christian) this was proposed in the manual
    int const opt_order_l = 5; // TODO(christian) We could even have different adaptive values for each dimension - need to change the code a bit in this case.
    int const opt_order_r = 5;
    string const opt_cutoff = "1e-15";
    int const opt_precision = 53;
    
    // declare state variables
    string str = "\"hybrid reachability {\nstate var ";
    for (unsigned i = 0; i < X_0.dimension(); i++) {
        if (i > 0) {
             str += ",";
        }
        str += index2varName[i];
    }
    
    // define settings
    str += "\nsetting {";
    // - steps
    if (opt_steps_l == opt_steps_r) {
        str += "\nfixed steps " + to_string(opt_steps_l);
    } else {
        str += "\nadaptive steps { min " + to_string(opt_steps_l) + ", max " +
               to_string(opt_steps_r) + " }";
    }
    // - time
    str += "\ntime " + to_string(T.rightBound());
    // - remainder estimation
    str += "\nremainder estimation " + opt_remainder;
    // - QR precondition
    str += "\n" + opt_precondition + " precondition";
    // - plotting
    /* TODO(christian) This is not good:
     * 1) Why do we have to plot at all?
     * 2) What happens when there is only one variable?
     */
    str += "\n gnuplot interval " + index2varName[0] + "," + index2varName[1];
    // - Taylor model order
    if (opt_order_l == opt_order_r) {
        str += "\nfixed orders " + to_string(opt_order_l);
    } else {
        str += "\nadaptive orders { min " + to_string(opt_order_l) + ", max " +
               to_string(opt_order_r) + " }";
    }
    // threshold when a term is considered small to be cut off to the remainder
    str += "\ncutoff " + opt_cutoff;
    // - precision in the MPFR library
    str += "\nprecision " + to_string(opt_precision);
    // - output file
    str += "\noutput " + outputFileName;
    // jumps (none)
    str += "\nmax jumps 0";
    // - printing
    str += "\nprint off";
    str += "\n}\n";
    
    // define flow
    str += "modes { mode1 {\n";
    if (opt_ode_mode == 1) {
        str += "poly ode 1";
    } else if (opt_ode_mode == 2) {
        str += "poly ode 2";
    } else {
        str += "nonpoly ode";
    }
    str += " {\n";
    int i = 0;
    while (!var_list->isEnil()) {
        // read flow from data structure
        string name = index2varName[i];
        stringstream ss;
        Enode * const func = flow_map[name];
        func->print_infix(ss, true, "");
        
        // add flow string
        if (forward_dynamics) {
            str += name + "' = " + ss.str() + "\n";
        } else {
            str += name + "' = " + "-(" + ss.str() + ")\n";
        }
        
        // continue in list
        var_list = var_list->getCdr()->getCdr();
        ++i;
    }
    
    // define invariant
    str += "}\ninv {";
    for (unsigned i = 0; i < inv.dimension(); ++i) {
        interval const & invI = inv[i];
        string varName = index2varName[i];
        str += "\n" + varName + " >= " + to_string(invI.leftBound());
        str += "\n" + varName + " <= " + to_string(invI.rightBound());
    }
    
    // define jumps (none)
    str += "\n}\n}}\njumps {";
    
    // define initial states
    str += "}\ninit { mode1 {\n";
    for (unsigned i = 0; i < X_0.dimension(); i++) {
        interval const & x_0 = X_0[i];
        str += index2varName[i] + " in [" + to_string(x_0.leftBound()) + " , " +
               to_string(x_0.rightBound()) + "]\n";
    }
    str += "}}\n}\"";
    
    return str;
}

ode_solver::ODE_result ode_solver::simple_ODE_backward(IVector & X_0, IVector const & X_t, interval const & T,
                                                       IVector const & inv, vector<IFunction> & funcs) {
    bool prune_params_result = prune_params();
    if (!prune_params_result) {
        return ODE_result::UNSAT;
    }

    // X_0 = X_0 \cup (X_t - + (d/dt Inv) * T)
    for (unsigned i = 0; i < X_0.dimension(); i++) {
        interval & x_0 = X_0[i];
        interval const & x_t = X_t[i];
        IFunction & dxdt = funcs[i];
        set_params(dxdt);
        try {
            interval const new_x_0 = x_t - dxdt(inv) * T;
            if (!intersection(new_x_0, x_0, x_0)) {
                DREAL_LOG_INFO << "ode_solver::simple_ODE_backward: no intersection for X_0 => UNSAT";
                return ODE_result::UNSAT;
            }
        } catch (exception& e) {
            DREAL_LOG_FATAL << "ode_solver::simple_ODE_backward: Exception in Simple_ODE: " << e.what();
        }
    }
    // update
    IVector_to_varlist(X_0, m_0_vars);
    return ODE_result::SAT;
}

double ode_solver::logVolume_X0(rp_box b) const {
    double ret = 0;
    for (Enode * var : m_0_vars) {
        double const lb = rp_binf(rp_box_elem(b, m_enode_to_rp_id[var]));
        double const ub = rp_bsup(rp_box_elem(b, m_enode_to_rp_id[var]));
        double const s = max(ub - lb, m_config.nra_precision);
        ret += log(s);
    }
    return ret;
}
double ode_solver::logVolume_Xt(rp_box b) const {
    double ret = 0;
    for (Enode * var : m_t_vars) {
        double const lb = rp_binf(rp_box_elem(b, m_enode_to_rp_id[var]));
        double const ub = rp_bsup(rp_box_elem(b, m_enode_to_rp_id[var]));
        double const s = max(ub - lb, m_config.nra_precision);
        ret += log(s);
    }
    return ret;
}

vector<double> ode_solver::extract_X0T(rp_box b) const {
    vector<double> ret;
    ret.emplace_back(m_mode); // Mode
    // Time
    ret.emplace_back(rp_binf(rp_box_elem(b, m_enode_to_rp_id[m_time])));
    ret.emplace_back(rp_bsup(rp_box_elem(b, m_enode_to_rp_id[m_time])));
    // X_0
    for (Enode * var : m_0_vars) {
        ret.emplace_back(rp_binf(rp_box_elem(b, m_enode_to_rp_id[var])));
        ret.emplace_back(rp_bsup(rp_box_elem(b, m_enode_to_rp_id[var])));
    }
    return ret;
}

vector<double> ode_solver::extract_XtT(rp_box b) const {
    vector<double> ret;
    ret.emplace_back(m_mode); // Mode
    // Time
    ret.emplace_back(rp_binf(rp_box_elem(b, m_enode_to_rp_id[m_time])));
    ret.emplace_back(rp_bsup(rp_box_elem(b, m_enode_to_rp_id[m_time])));
    // X_t
    for (Enode * var : m_t_vars) {
        ret.emplace_back(rp_binf(rp_box_elem(b, m_enode_to_rp_id[var])));
        ret.emplace_back(rp_bsup(rp_box_elem(b, m_enode_to_rp_id[var])));
    }
    return ret;
}

vector<double> ode_solver::extract_X0XtT(rp_box b) const {
    vector<double> ret;
    ret.emplace_back(m_mode); // Mode
    // Time
    ret.emplace_back(rp_binf(rp_box_elem(b, m_enode_to_rp_id[m_time])));
    ret.emplace_back(rp_bsup(rp_box_elem(b, m_enode_to_rp_id[m_time])));
    // X_0
    for (Enode * var : m_0_vars) {
        ret.emplace_back(rp_binf(rp_box_elem(b, m_enode_to_rp_id[var])));
        ret.emplace_back(rp_bsup(rp_box_elem(b, m_enode_to_rp_id[var])));
    }
    // X_t
    for (Enode * var : m_t_vars) {
        ret.emplace_back(rp_binf(rp_box_elem(b, m_enode_to_rp_id[var])));
        ret.emplace_back(rp_bsup(rp_box_elem(b, m_enode_to_rp_id[var])));
    }
    return ret;
}

ostream& operator<<(ostream& out, ode_solver::ODE_result ret) {
    switch (ret) {
    case ode_solver::ODE_result::SAT:
        out << "SAT";
        break;
    case ode_solver::ODE_result::UNSAT:
        out << "UNSAT";
        break;
    case ode_solver::ODE_result::TIMEOUT:
        out << "TIMEOUT";
        break;
    case ode_solver::ODE_result::EXCEPTION:
        out << "EXCEPTION";
        break;
    }
    return out;
}
}
