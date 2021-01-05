`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:43:11 05/03/2020
// Design Name:   divideBy2ToTheN
// Module Name:   /home/ise/Project3/divideBy2ToTheN_tb.v
// Project Name:  Project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: divideBy2ToTheN
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module divideBy2ToTheN_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	//wire [31:0] clkOut;
	//wire [3:0] clkOut;
	wire divBy2;
	wire divBy4;
	wire divBy8;
	wire divBy16;

	// Instantiate the Unit Under Test (UUT)
	divideBy2ToTheN uut (
		.clk(clk), 
		.rst(rst),  
		//.clkOut(clkOut),
		.divBy2(divBy2),
		.divBy4(divBy4),
		.divBy8(divBy8),
		.divBy16(divBy16)
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

