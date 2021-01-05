`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Engineer:		Gabriella Long
//						
// Create Date:   01:14:34 05/26/2020
// Design Name:   parking_meter
// Module Name:   /home/ise/Project5/testbench_605291133.v
// Project Name:  Project5
// Verilog Test Fixture created by ISE for module: parking_meter
// Revision:
// Revision 0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module testbench_605291133;

	reg clk;
	reg rst;
	reg add1;
	reg add2;
	reg add3;
	reg add4;
	reg rst1;
	reg rst2;
	
	// Outputs
	wire [3:0] val4;
	wire [3:0] val3;
	wire [3:0] val2;
	wire [3:0] val1;
	wire [6:0] led_seg;
	

	// Instantiate the Unit Under Test (UUT)
	parking_meter uut (
		.clk(clk),
		.rst(rst),
		.add1(add1),
		.add2(add2),
		.add3(add3),
		.add4(add4),
		.rst1(rst1),
		.rst2(rst2),
		.val4(val4),
		.val3(val3),
		.val2(val2),
		.val1(val1),
		.led_seg(led_seg)
	);

	always #10 clk = ~clk;
	
	initial begin
		clk = 0;
		rst = 0;
		add1 = 0;
		add2 = 0;
		add3 = 0;
		add4 = 0;
		rst1 = 0;
		rst2 = 0;
	
		//test case #1
		#70
		add1 = 1;
		
		#20
		add1 = 0;
		
		#100
		rst = 1;
		
		#20
		rst = 0;
		
		#10
		rst1 = 1;
		
		#20
		rst1 = 0;
		
		//test case #2
		#200
		add2 = 1;
		
		#20
		add2 = 0;
		
		#50
		rst1 = 1;
		
		#20
		rst1 = 0;
		
		//test case #3
		#50
		add3 = 1;
		
		#20
		add3 = 0;
		
		#50
		rst2 = 1;
		
		#20
		rst2 = 0;
		
		//test case #4 
		#100
		add4 = 1;
		
		#20
		add4 = 0;
		
		#70
		rst2 = 1;
		
		#20
		rst2 = 0;
		
		//test case #5
		#100
		add1 = 1;
		
		#20
		add1 = 0;
		
		#50
		add2 = 1;
		
		#20
		add2 = 0;
		
		#100 //get to 120 before rst // check this
		rst2 = 1;
		
		#20
		rst2 = 0;
		
		//test case #6
		#50
		add3 = 1;
		
		#20 
		add3 = 0;
		
		//test case #7
		#100
		add1 = 1;
		
		#20
		add1 = 0;
		
		#100
		add4 = 1;
		
		#20
		add4 = 0;
		
		//test case #8
		#30
		add4 = 1;
		
		#20
		add4 = 0;
		
		
		//test case #9
		#120 
		rst = 1;
		
		#50
		rst = 0;
		
		#50
		add4 = 1;
		
		
		#350
		$finish; 
			  
		// Add stimulus here

	end
      
endmodule

