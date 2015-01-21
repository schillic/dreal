/*
 * sspaceex_api.h
 *
 *  Created on: Nov 27, 2014
 *      Author: Marius Greitschus
 */

#ifndef SSPACEEX_API_H_
#define SSPACEEX_API_H_

#define SPACEEX_EXPORT extern "C" __attribute__ ((visibility ("default")))

/**
 * The size of the buffer for returned strings
 */
#define BUFFSIZE 1024

/**
 * Defines a single location containing some invariant and some dynamic behavior flow.
 *
 * Note: The invariant and the flow must be given as a SpaceEx-comprehensible string. Usually, boolean C expressions
 * should suffice, e.g.
 *    "x >= 5 && x <= 10 && y == 20"
 */
typedef struct {
	const char* invariant;
	const char* flow;
} location;

/**
 * Defines the valuation of some variable. The valuation is given as a string of the form
 *    "[min, max]"
 */
typedef struct {
	char variable_name[BUFFSIZE];
	char valuation_char[BUFFSIZE];
	double lower_bound;
	double upper_bound;
} spaceex_variable_valuation;

/**
 * Possible return values of SpaceEx' computation
 */
typedef enum {
	OK,   //!< OK 		= Everything went fine
	WARN, //!< WARN 	= There were some warnings issued
	ERROR, //!< ERROR	= There was an error during the computation
} spaceex_result_value;

/**
 * Defines a result returned from SpaceEx' continuous post computation. A spaceex_result is comprised of an array of
 * variable valuations and the size of the array.
 *
 * In addition to the valuation, a return value is being returned, stating whether the calculation with SpaceEx was
 * successful. If there was an error or a warning, the return_message contains additional information concerning the
 * result.
 */
typedef struct {
	spaceex_variable_valuation* variable_results;
	int size;
	spaceex_result_value return_value;
	const char* return_message;
} spaceex_result;

/**
 * Defines the output variables and their number to be used for the output of continuous_post.
 */
typedef struct {
	const char** variables;
	int size;
} output_variables;

/**
 * Returns the version information of the SpaceEx library
 * @return
 */
SPACEEX_EXPORT const char* version_info();

/**
 * Calculates the continuous post for a given location and a given initial set, and writes the output in result
 * according to some specified output variables.
 *
 * Note that you need to initialize an array of fitting size in the result that you pass to this function.
 *
 * @param loc
 * @param initial
 * @param output_vars
 * @param result
 */
SPACEEX_EXPORT void continuous_post(const location& loc, const char* initial, const output_variables& output_vars,
		spaceex_result& result);

/**
 * Sets the time horizon for the analysis.
 * @param time_horizon
 */
SPACEEX_EXPORT void set_time_horizon(int time_horizon = 1000);

/**
 * Sets the sampling time for the analysis.
 * @param sampling_time
 */
SPACEEX_EXPORT void set_sampling_time(double sampling_time = 0.01);

/**
 * Intersects a given calculated result with a given bad state.
 *
 * Returns true, if and only if an intersection with the bad state has been found, false otherwise.
 *
 * Note that in case of a return value of false, there might have happened an error which can be obtained through the
 * returned return code and error message.
 *
 * @param bad_state
 * @param result
 * @param result_value
 * @param message
 * @return
 */
SPACEEX_EXPORT bool intersect_with_bad_state(const char* bad_state, spaceex_result& result,
		spaceex_result_value& result_value, char message[BUFFSIZE]);

#endif /* SSPACEEX_API_H_ */
