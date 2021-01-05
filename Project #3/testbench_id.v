`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:51:35 05/08/2020
// Design Name:   clock_gen
// Module Name:   /home/ise/Project3/testbench_605291133.v
// Project Name:  Project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_gen
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
	reg clkIn;
	reg rst;

	// Outputs
	wire clk_div_2;
	wire clk_div_4;
	wire clk_div_8;
	wire clk_div_16;
	wire clk_div_28;
	wire clk_div_5;
	wire [7:0] glitchy_counter;

	// Instantiate the Unit Under Test (UUT)
	clock_gen uut (
		.clkIn(clkIn), 
		.rst(rst), 
		.clk_div_2(clk_div_2), 
		.clk_div_4(clk_div_4), 
		.clk_div_8(clk_div_8), 
		.clk_div_16(clk_div_16), 
		.clk_div_28(clk_div_28), 
		.clk_div_5(clk_div_5), 
		.glitchy_counter(glitchy_counter)
	);

	always #10 clkIn = ~clkIn;

	initial begin
		// Initialize Inputs
		//clkIn = 1'b1;
		clkIn = 0;
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

