`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:09:49 05/08/2020
// Design Name:   glitchyCounter
// Module Name:   /home/ise/Project3/glitch_tb.v
// Project Name:  Project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: glitchyCounter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module functioning_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] glitchOut;
	//wire divBy4;

	// Instantiate the Unit Under Test (UUT)
	functioningCounter uut (
		.clk(clk), 
		.rst(rst), 
		.glitchOut(glitchOut)
		//.divBy4(divBy4)
	);

	always #10 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 1'b1;
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

