#include "sspaceex_api.h"

#include <string>
#include <vector>
#include <iostream>

int main(int argc, char* argv[])
{

	std::string inv;
	std::string flo;
	std::string ini;
	
	// Handle the command line arguments
	if (argc == 1) {
		inv = "v <= 0 && x >= 0 && g == -9.81 && t >= 0 && t <= 1000";
		flo = "x' == v && v' == g && t' == 1 && g' == 0";
		ini = "x==10 && v==0 && g == -9.81 && t==0";
 	}
	else if (argc != 4) {
		inv = argv[1];
		flo = argv[2];
		ini = argv[3];
	}
	else {
		std::cout << "Usage: ./test \"<invariant>\" \"<dynamics>\" \"<initial>\"" << std::endl;
		return 0;
	}

	// Print some version information
	std::string version = version_info();
	std::cout << version << std::endl << std::endl;

	// Convert the converted strings to const char*
 	std::vector<char> invariant(inv.begin(), inv.end());
	invariant.push_back('\0');

	std::vector<char> flow(flo.begin(), flo.end());
	flow.push_back('\0');

	std::vector<char> initial(ini.begin(), ini.end());
	initial.push_back('\0');

	// Create a location that should be analyzed with invariant and dynamic behavior
	location loc;
	loc.invariant = &invariant[0];
	loc.flow = &flow[0];

	// Define the output variables
	output_variables outputs;
	outputs.size = 4;	// NOTE: You must set the number of output variables here
	const char* vars[] = {"x", "t", "v", "g"};
	outputs.variables = vars;

	// Set the desired time horizon and sampling time
	set_time_horizon(1000);
	set_sampling_time(0.01);

	// Define the struct that is to be returned from SpaceEx.
	spaceex_result result;
	spaceex_variable_valuation resvals[10];		// NOTE: This array here must be able to hold enough elements
	result.variable_results = resvals;

	// ----------- Call the continuous post calculation of SpaceEx -----------
	continuous_post(loc, &initial[0], outputs, result);

	// Check the return value. If there was a warning or an error, print it and exit.
	if (result.return_value != OK) {
		std::cerr << "There was an error during the execution of SpaceEx:" << std::endl;

		std::cerr << result.return_message << std::endl;

		return 1;
	}

	// Print the result
	std::cout << "Result:" << std::endl;

	for (int i = 0; i < result.size; ++i) {
		spaceex_variable_valuation& var_val = result.variable_results[i];
		std::cout << var_val.variable_name << " == " << var_val.valuation_char << " -- As double: [" << var_val.lower_bound << ", " << var_val.upper_bound << "]" << std::endl;
	}

	// Intersect the result with a bad state
	const char* bad_state = "x > 9";

	spaceex_result_value intersection_result;
	char msg[BUFFSIZE];
	constraints_result intersection_constraints;

	spaceex_tribool res = intersect_with_bad_state(bad_state, result, intersection_result, msg, intersection_constraints);

	if (res.unknown) {
		std::cout << "The intersection result is unknown." << std::endl;
		return 0;
	}

	if (res) {
		std::cout << "There is an intersection with the bad state." << std::endl;
	}
	else {
		if (intersection_result == OK) {
			std::cout << "No intersection with the bad state has been found." << std::endl;
		}
		else {
			std::cerr << "Abnormal program termination: Something went wrong in the intersection calculation:" << std::endl;
			return 1;
		}
	}

	std::cout << "Result: " << msg << std::endl;

	if (res) {
		std::cout << "The intersection consists of " << intersection_constraints.size << " constraints:" << std::endl;

		for (int i = 0; i < intersection_constraints.size; ++i) {
			std::cout << intersection_constraints.constraints[i].valuation_char << "    ";

			std::cout << "From original values: ";

			std::cout << intersection_constraints.constraints[i].variable_name;
			
			switch (intersection_constraints.constraints[i].sign) {
			case SIGN_LT:
				std::cout << " < ";
				break;
			case SIGN_LE:
				std::cout << " <= ";
				break;
			case SIGN_GT:
				std::cout << " > ";
				break;
			case SIGN_GE:
				std::cout << " >= ";
				break;
			case SIGN_EQ:
				std::cout << " == ";
				break;
			default:
				std::cerr << "Unknown sign" << std::endl;
				return 1;
			}

			std::cout << intersection_constraints.constraints[i].value << std::endl;
		}
	}

	return 0;
}
