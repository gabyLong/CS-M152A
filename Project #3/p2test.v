`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:06:38 05/04/2020
// Design Name:   p2divider
// Module Name:   /home/ise/Project3/p2test.v
// Project Name:  Project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: p2divider
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module p2test;

	// Inputs
	reg clockin;

	// Outputs
	wire clockout;

	// Instantiate the Unit Under Test (UUT)
	p2divider uut (
		.clockin(clockin), 
		.clockout(clockout)
	);
	
	always #5 clockin = ~clockin;
	
	initial begin
		// Initialize Inputs
		clockin = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

