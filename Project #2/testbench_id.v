`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:20:04 04/26/2020
// Design Name:   FPCVT
// Module Name:   /home/ise/Project2/testbench_id.v
// Project Name:  Project2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FPCVT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_605291133;

	// Inputs
	reg [12:0] D;

	// Outputs
	wire S;
	wire [2:0] E;
	wire [4:0] F;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		.D(D), 
		.S(S), 
		.E(E), 
		.F(F)
	);

	initial begin
		// Initialize Inputs
		D = 0;

		// Wait 100 ns for global reset to finish
		//Used values from project guide to check output
		#100;
      D = 1;
		
		#100;
		D = 422;
		
		#100;
		D = -104;
		
		#100;
		D = 140;
		
		#100;
		D = 0;
		
		#200 $finish;
 
	end
      
endmodule

