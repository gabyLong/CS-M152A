`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 		 Gabriella Long
// 					 
// Create Date:    01:22:08 05/03/2020 
// Design Name: 
// Module Name:    clock_gen 
// Project Name: 	 Project 3
// Revision: 
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////
module clock_gen(
	input wire clkIn,
	input wire rst,
	output wire clk_div_2,
	output wire clk_div_4,
	output wire clk_div_8,
	output wire clk_div_16,
	output wire clk_div_28,
	output wire clk_div_5,
	output wire [7:0] glitchy_counter
   );
	 
	divideBy2ToTheN db2n(
		.clk(clkIn), 
		.rst(rst), 
		.divBy2(clk_div_2),
		.divBy4(clk_div_4),
		.divBy8(clk_div_8),
		.divBy16(clk_div_16)
		);
	
	evenDivision ediv(
		.clk(clkIn),
		.rst(rst),
		.divBy28(clk_div_28)
		);
	
	oddDivision oDiv(
		.clk(clkIn),
		.rst(rst),
		.divBy5(clk_div_5)
		);
	
	glitchyCounter gCount(
		.clk(clkIn),
		.rst(rst),
		.glitchOut(glitchy_counter)
		);

endmodule

//used code from project 1, only modified names
module divideBy2ToTheN(
	input wire clk,
	input wire rst,
	output wire divBy2,
	output wire divBy4,
	output wire divBy8,
	output wire divBy16
	);
	
	reg [3:0] clkOut;
	
	always @ (negedge clk) 
	begin
		if (rst)
			clkOut <= 4'b0000;
		else
			clkOut <= clkOut + 1'b1;
	end
	
	assign divBy2 = clkOut[0];
	assign divBy4 = clkOut[1];
	assign divBy8 = clkOut[2];
	assign divBy16 = clkOut[3];
	
endmodule

//generate divide by 28
module evenDivision(
	input wire clk,
	input wire rst,
	output reg divBy28
	);
	
	
	reg [3:0] clkOut;
	
	initial 
	begin
		divBy28 <= 0;
		clkOut <= 0;
	end

	
	//always @ (negedge clk) 
	always @ (posedge clk)
	begin
		if (clkOut > 12)
		begin
			clkOut <= 4'b0000;
			divBy28 <= ~divBy28;
		end
		else
			clkOut <= clkOut + 1'b1;
	end
	
endmodule

//divide by 5 clock
module oddDivision(
	input wire clk,
	input wire rst,
	output wire divBy5	
	);

	reg flip_1;
	reg flip_2;
	reg flip_3;
	reg tempFlip; 
	
	initial 
	begin
		flip_1 <= 0;
		flip_2 <= 0;
		flip_3 <= 0;
		tempFlip <= 0;
	end
	
	reg negFlip_1;
	reg negFlip_2;
	reg negFlip_3; 

	always @ (*)
	begin
		negFlip_1 = ~flip_1;
		negFlip_2 = ~flip_2;
		negFlip_3 = ~flip_1;
	end
	
	wire tempData_1;
	wire tempData_2;
	wire tempData_3;
	
	assign tempData_1 = (flip_2 & flip_3);
	assign tempData_2 = ((negFlip_2 & flip_3) | (flip_2 & negFlip_3));
	assign tempData_3 = (negFlip_3 & negFlip_1);
	
	wire data_1;
	wire data_2; 
	wire data_3;
	
	assign data_1 = tempData_1;
	assign data_2 = tempData_2;
	assign data_3 = tempData_3;
	
	//always @(negedge clk) 
	always @ (posedge clk)
	begin
		flip_1 <= data_1;
		flip_2 <= data_2;
		flip_3 <= data_3;
	end
	
	//always @(posedge clk) 
	always @ (negedge clk)
	begin
		tempFlip <= flip_2;
	end
	
	wire tempDivBy5 = (tempFlip | flip_2);

	assign divBy5 = tempDivBy5;
	
endmodule

module glitchyCounter(
	input wire clk,
	input wire rst,
	output reg [7:0] glitchOut
	//output wire divBy4
	);
	
	reg [3:0] clkOut;
	
	always @ (posedge clk) 
	begin
		if (rst)
			clkOut <= 4'b0000;
		else
			clkOut <= clkOut + 1'b1;
	end
	
	assign divBy4 = clkOut[1];
	reg enable;
	reg [3:0] clockCounter;

	always @ (posedge clk or posedge rst or posedge divBy4)
	begin
		if (rst)
			glitchOut <= 8'b0;
		else
		begin
			if (divBy4)
				enable <= 1'b1;
			else
			begin
				glitchOut <= glitchOut + 2'b10;
				//clockCounter <= clockCounter + 1;
			end
			
			if (enable == 1'b1)
			begin
				glitchOut <= glitchOut - 3'b101;
				enable <= 1'b0;
				//clockCounter <= 0;
			end
			//clockCounter <= clockCounter + 1;
		end
	end
endmodule

module functioningCounter(
	input wire clk,
	input wire rst,
	output reg [7:0] glitchOut
	//output wire divBy4
	);
	
	reg [3:0] clkOut;

	
	always @ (posedge clk) 
	begin
		if (rst)
			clkOut <= 4'b0000;
		else
			clkOut <= clkOut + 1'b1;
	end
	
	assign divBy4 = clkOut[1];
	reg enable;

	
	always @ (posedge clk or posedge rst or negedge divBy4)
	begin
		if (rst)
			glitchOut <= 8'b0;
		else
		begin
			if (divBy4)
			begin
				enable <= 1'b1;
				//glitchOut <= glitchOut + 2'b10;
			end
			else
			begin
				glitchOut <= glitchOut + 2'b10;
			end
				
			if (enable == 1'b1)
			begin
				glitchOut <= glitchOut - 5;
				enable <= 1'b0;
			end
		end
	end
endmodule

////////////////////////////////////////////////////
//				BELOW IS THE EXTRA TASKS
////////////////////////////////////////////////////
module subModules(
	input wire clk,
	input wire rst,
	output wire divBy32,
	output wire thirty3DutyRising,
	output wire thirty3DutyFalling,
	output wire or33Duty,
	output wire divideBy200
	);
	
	divideBy32 db32(
		.clk(clk), 
		.rst(rst), 
		.diviBy32(divBy32)
		);
		
	thirty3 db33(
		.clk(clk), 
		.rst(rst), 
		.thirty3DutyRising(thirty3DutyRising),
		.thirty3DutyFalling(thirty3DutyFalling),
		.or33Duty(or33Duty)
		);

	divBy200 db200(
		.clk_500(clk),
		.rst(rst),
		.divBy200(divideBy200)
		);
	
	
endmodule

module divideBy32(
	input wire clk,
	input wire rst,
	output reg diviBy32
	);
	
	reg [3:0] clkOut;
	
	initial 
	begin
		diviBy32 <= 0;
		clkOut <= 0;
	end
	
	always @ (posedge clk) 
	begin
		if (clkOut > 1)
		begin
			clkOut <= 4'b0000;
			diviBy32 <= ~diviBy32;
		end
		else
			clkOut <= clkOut + 1'b1;
	end
endmodule

module thirty3(
	input wire clk,
	input wire rst,
	output wire thirty3DutyRising,
	output wire thirty3DutyFalling,
	output wire or33Duty
	);
	
	reg flip_1;
	reg flip_2;
	reg flip_3;
	reg flip_4;
	reg [1:0] counter;
	
	initial 
	begin
		flip_1 <= 0;
		flip_2 <= 0;
		flip_3 <= 0;
		flip_4 <= 0;
		counter <= 0;
	end
	
	always @ (posedge clk) 
	begin
		counter <= counter + 1'b1;
		if (counter == 2'b10)
		begin
			counter <= 1'b0;
		end
	end
	
	always @ (posedge counter)
	begin
		if (counter == 2'b00)
		begin
			flip_1 <= 1'b1;
		end
		else
		begin
			flip_1 <= 1'b0;
		end
	end
	
	always @(negedge clk) 
	begin
		flip_2 <= flip_1;
	end
	
	wire tempDiv;
	assign tempDiv = (flip_1 | flip_2);
	assign thirty3DutyRising = tempDiv;
	
	
	always @ (posedge clk) 
	begin
		counter <= counter + 1'b1;
		if (counter == 2'b10)
		begin
			counter <= 1'b0;
		end
	end
	
	always @ (negedge counter)
	begin
		if (counter == 2'b00)
		begin
			flip_3 <= 1'b1;
		end
		else
		begin
			flip_3 <= 1'b0;
		end
	end
	
	always @(negedge clk) 
	begin
		flip_4 <= flip_3;
	end
	
	wire tempDiv2;
	assign tempDiv2 = (flip_3 | flip_4);
	assign thirty3DutyFalling = tempDiv2;
	
	wire temp3;
	assign temp3 = (thirty3DutyRising | thirty3DutyFalling);
	assign or33Duty = temp3;
	
endmodule

module divBy200(
	input wire clk_500,
	input wire rst,
	output wire divBy200
	);
	reg [15:0] twoHundredCounter;
	
	initial 
	begin
		twoHundredCounter <= 0;
		//divBy200 <= 0;
	end
	
	
	always @ (posedge clk_500 or posedge rst)
	begin
		if (rst)
			twoHundredCounter <= 0;
		else
		begin
			twoHundredCounter <= twoHundredCounter + 1;
			
		end
		
		
		/*
		twoHundredCounter <= twoHundredCounter + 200;
		
		if (twoHundredCounter >= 200)
		begin
			divBy200 <= 1'b1;
			twoHundredCounter <= ~twoHundredCounter + 1;//twoHundredCounter - 200;
		end
		else if (twoHundredCounter <= 199)
		begin
			divBy200 <= 0;
		end
		*/
		
	end
	assign divBy200 = twoHundredCounter[8];
endmodule
	
