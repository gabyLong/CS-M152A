`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:59:39 05/10/2020
// Design Name:   subModules
// Module Name:   /home/ise/Project3/subModules_tb.v
// Project Name:  Project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: subModules
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module subModules_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire divBy32;
	wire thirty3DutyRising;
	wire thirty3DutyFalling;
	wire or33Duty;
	wire divideBy200;

	// Instantiate the Unit Under Test (UUT)
	subModules uut (
		.clk(clk), 
		.rst(rst), 
		.divBy32(divBy32), 
		.thirty3DutyRising(thirty3DutyRising), 
		.thirty3DutyFalling(thirty3DutyFalling), 
		.or33Duty(or33Duty), 
		.divideBy200(divideBy200)
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

		#3000 $finish;
	end
      
endmodule

