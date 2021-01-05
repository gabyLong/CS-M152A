`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:47:56 05/05/2020
// Design Name:   evenDivision
// Module Name:   /home/ise/Project3/evenDivision_tb.v
// Project Name:  Project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: evenDivision
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module evenDivision_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire divBy28;

	// Instantiate the Unit Under Test (UUT)
	evenDivision uut (
		.clk(clk), 
		.rst(rst), 
		.divBy28(divBy28)
	);

	always #10 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		//N = 0;

		// Wait 50 ns for global reset to finish
		
		#50;
		rst = 1;
		
		#80;
		rst = 0;
		//N = 2;
		
		#50;
		rst = 1;

		#20;
		rst = 0;
		
		
		// Add stimulus here

		#600 $finish;
	end
      
endmodule

