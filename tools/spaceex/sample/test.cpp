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
		std::cout << var_val.variable_name << " == " << var_val.valuation << std::endl;
	}

	return 0;
}
