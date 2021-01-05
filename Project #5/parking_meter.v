`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Gabriella Long
// 					
// Create Date:    01:13:59 05/26/2020  
// Module Name:    parking_meter 
// Project Name:	 Project 5
// Revision: 
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////
module parking_meter(
	input wire clk,
	input wire rst,
	input wire add1,
	input wire add2,
	input wire add3,
	input wire add4,
	input wire rst1,
	input wire rst2,
	output wire [3:0] val4,
	output wire [3:0] val3,
	output wire [3:0] val2,
	output wire [3:0] val1,
	output wire [6:0] led_seg
	//output reg [1:0] current_state,
	//output reg [1:0] next_state
	//output wire blinkClk
   );
	
	reg [1:0] current_state;
	reg [1:0] next_state;
	
	reg [3:0] tensMin;
	reg [3:0] min;
	reg [3:0] tensSec;
	reg [3:0] sec;
	
	parameter [1:0] INITIAL = 2'b00;
	parameter [1:0] ADD_TIME = 2'b01;
	parameter [1:0] COUNT_DOWN = 2'b10;
	parameter [1:0] LOW_TIME = 2'b11;
	
	
	reg [6:0] tensMinSeg;
	reg [6:0] minSeg;
	reg [6:0] tensSecSeg;
	reg [6:0] secSeg;
	reg [1:0] counter = 2'b00;
	wire [6:0] blankSeg;
	/*
	outputMod segmentLSD(.anodes(sec), .valOut(led_seg));
	//outputMod segmentLSD_2(.anodes(tensSec), .valOut(tensSecSeg));
	outputMod segmentLSD_3(.anodes(min), .valOut(minSeg));
	outputMod segmentLSD_4(.anodes(tensMin), .valOut(tensMinSeg));
	outputMod blankOut(.anodes(4'b1111), .valOut(blankSeg));
	*/
	/*
	always @ (posedge clk)
	begin
		if (counter == 0)
		begin
			led_seg <= tensMinSeg;
			counter <= counter + 1;
		end
		if (counter == 1)
		begin
			led_seg <= minSeg;
			counter <= counter + 1;
		end
		if (counter == 2)
		begin
			led_seg <= tensSecSeg;
			counter <= counter + 1;
		end
		if (counter == 3)
		begin
			led_seg <= secSeg;
			counter <= counter + 1;
		end
	end
	*/

	outputMod segmentLSD(.anodes(sec), .valOut(led_seg));
	
	assign val1 = sec;
	assign val2 = tensSec;
	assign val3 = min;
	assign val4 = tensMin;
	
	always @ (posedge clk)
	begin
		if (rst)
			current_state <= INITIAL;
		else
			current_state <= next_state;
	end

	reg rstFlag;
	reg add1Flag;
	reg add2Flag;
	reg add3Flag;
	reg add4Flag;
	reg rst1Flag;
	reg rst2Flag;
	
	always @ (negedge rst)
	begin
		if (rst)
			rstFlag = 1'b1;
		else
			rstFlag = 0;
	end
	
	always @ (posedge add1)
	begin
		if (add1)
			add1Flag <= 1;
		else 
			add1Flag <= 0;
	end
	
	always @ (posedge add2)
	begin
		if (add2)
			add2Flag <= 1;
		else
			add2Flag <= 0;
	end
	
	always @ (posedge add3)
	begin
		if (add3)
			add3Flag <= 1;
		else
			add3Flag <= 0;
	end
	
	always @ (posedge add4)
	begin
		if (add4)
			add4Flag <= 1;
		else
			add4Flag <= 0;
	end
	
	always @ (posedge rst1)
	begin
		if (rst1)
			rst1Flag <= 1;
		else
			rst1Flag <= 0;
	end
	
	always @ (posedge rst2)
	begin
		if (rst2)
			rst2Flag <= 1;
		else
			rst2Flag <= 0;
	end
	
	initial begin
		tensMin = 4'b0000;
		min = 4'b0000;
		tensSec = 4'b0000;
		sec = 4'b0000;
	end
	
	reg blinkFlag;
	reg tensMinBlink = 1'b0;
	reg minBlink = 1'b0;
	reg tensSecBlink = 1'b0;
	reg secBlink = 1'b0;
	//reg blinkClk;
	reg blinkBlank;
	
	/*
	blinkingClk bClk(
		.clock(clk), 
		.reset(rst), 
		.blinkingClk(blinkClk)
		);
	*/
	
	always @ (posedge clk)//(*)
	case (current_state)
	INITIAL : begin //state 000
			tensMin <= 4'b0000;
			min <= 4'b0000;
			tensSec <= 4'b0000;
			sec <= 4'b0000;
			
			if (rstFlag == 1)
			begin
				tensMin <= 4'b0000;
				min <= 4'b0000;
				tensSec <= 4'b0000;
				sec <= 4'b0000;
				blinkFlag <= 1;
			end
			else if (add1Flag == 1)
				next_state <= ADD_TIME;
			else if (add2Flag == 1)
				next_state <= ADD_TIME;
			else if (add3Flag == 1)
				next_state <= ADD_TIME;
			else if (add4Flag == 1)
				next_state <= ADD_TIME;
			else if (rst1Flag == 1)
				next_state <= ADD_TIME;
			else if (rst2Flag == 1)
				next_state <= ADD_TIME;
			else if (tensMin == 4'b0000)
			begin
				if (min == 4'b0)
				begin
					if (tensSec == 4'b0)
					begin
						if (sec == 4'b0)
						begin
							next_state <= INITIAL;
							blinkFlag <= 1'b1;
						end
					end
				end	
			end
			else if (min == 4'b0)
			begin
				if (tensMin == 4'b0)
				begin
					if (tensSec == 4'b0)
					begin
						if (sec == 4'b0)
						begin
							next_state <= INITIAL;
							blinkFlag <= 1'b1;
						end
					end
				end	
			end
			else if (tensSec == 4'b0)
			begin
				if (min == 4'b0)
				begin
					if (tensMin == 4'b0)
					begin
						if (sec == 4'b0)
						begin
							next_state <= INITIAL;
							blinkFlag <= 1'b1;
						end
					end
				end	
			end
			else if (sec == 4'b0)
			begin
				if (min == 4'b0)
				begin
					if (tensSec == 4'b0)
					begin
						if (tensMin == 4'b0)
						begin
							next_state <= INITIAL;
							blinkFlag <= 1'b1;
						end
					end
				end	
			end
			/*
			else if (blinkFlag == 1)
			begin
				//blink tensMin
				if (counter == 2'b0)
				begin
					if (blinkClk)
						led_seg <= tensMin;
					else
						led_seg <= blinkBlank;
				
					counter <= counter + 1;
				end
				else if (counter == 2'b01) //blink mins 
				begin
					if (blinkClk)
						led_seg <= min;
					else
						led_seg <= blinkBlank;
				
					counter <= counter + 1;
						
				end
				else if (counter == 2'b10) //blick tensSec
				begin
					led_seg <= tensSec;
					counter <= counter + 1;
				end
				else if (counter == 2'b11) //blick sec
				begin
					led_seg <= sec;
					counter <= counter + 1;	
				end
			
				
				if (add1Flag == 1)
					next_state <= ADD_TIME;
				else if (add2Flag == 1)
					next_state <= ADD_TIME;
				else if (add3Flag == 1)
					next_state <= ADD_TIME;
				else if (add4Flag == 1)
					next_state <= ADD_TIME;
				else if (rst1Flag == 1)
					next_state <= ADD_TIME;
				else if (rst2Flag == 1)
					next_state <= ADD_TIME;
				
			end
			*/
			else
				next_state <= current_state;
		end
	ADD_TIME : begin
			if (rst == 1)
				next_state <= INITIAL;
			else if (add1Flag == 1) //add 60 seconds
			begin
				if (tensSec < 3)
				begin
					tensSec <= tensSec + 4'b0110;
				end
				else
				begin
					if (tensSec == 4)
					begin
						min <= min + 4'b0001;
						tensSec <= 4'b0;
					end
					else
					begin
						if (tensSec == 5)
						begin
							min <= min + 4'b0001;
							tensSec <= 4'b0001;
						end
						else
						begin
							if (tensSec == 6)
							begin
								min <= min + 4'b0001;
								tensSec <= 4'b0010;
							end
							else
							begin
								if (tensSec == 7)
								begin
									min <= min + 4'b0001;
									tensSec <= 4'b0011;
								end
								else
								begin
									if (tensSec == 8)
									begin
										min <= min + 4'b0001;
										tensSec <= 4'b0100;
									end
									else //(tensSec == 9)
									begin
										min <= min + 4'b0001;
										tensSec <= 4'b0101;
									end
								end
							end
						end
					end
				end
				
				//next_state <= COUNT_DOWN;
				add1Flag = 0;
			end
			else if (add2Flag == 1) //add 120 seconds
			begin
				if (min < 9)
				begin
					if (tensSec == 0)
					begin
						min <= min + 4'b0001;
						tensSec <= tensSec + 4'b0010;
					end
					else 
					begin
						if (tensSec == 1)
						begin
							min <= min + 4'b0001;
							tensSec <= tensSec + 4'b0010;
						end
						else 
						begin
							if (tensSec == 2)
							begin
								min <= min + 4'b0001;
								tensSec <= tensSec + 4'b0010;
							end
							else
							begin
								if (tensSec == 3)
								begin 
									min <= min + 4'b0001;
									tensSec <= tensSec + 4'b0010;
								end
								else 
								begin
									if (tensSec == 4)
									begin 
										min <= min + 4'b0001;
										tensSec <= tensSec + 4'b0010;
									end
									else 
									begin
										if (tensSec == 5)
										begin 
											min <= min + 4'b0001;
											tensSec <= tensSec + 4'b0010;
										end
										else
										begin
											if (tensSec == 6)
											begin 
												min <= min + 4'b0001;
												tensSec <= tensSec + 4'b0010;
											end
											else
											begin
												if (tensSec == 7)
												begin 
													min <= min + 4'b0001;
													tensSec <= tensSec + 4'b0010;
												end
												else
												begin
													if (tensSec == 8)
													begin
														min <= min + 4'b0001;
														tensSec <= tensSec + 4'b0010;
													end
													else//tensSec == 9
													begin
														min <= min + 4'b0010;
														tensSec <= 4'b0;
													end
												end
											end
										end
									end
								end	
							end		
						end
					end
				end
				else //min > 9
				begin
					if (tensMin < 9)
					begin
						if (tensSec < 9)
						begin
							tensSec <= tensSec + 4'b0010;
							tensMin <= tensMin + 4'b0001;
							min <= 4'b0;
						end
						else
						begin
							tensSec <= 4'b0;
							min <= 4'b0;
							tensMin <= tensMin + 4'b0010;
						end
					end
					else
					begin
						tensSec <= 4'b1001;
						tensMin <= 4'b1001;
						min <= 4'b1001;
						sec <= 4'b1001;
					end
				end
				//next_state <= COUNT_DOWN;
				add2Flag = 0;
			end
			else if (add3Flag == 1) //add 180 seconds
			begin
				if (min < 9)
				begin
					if (tensSec < 2)
					begin
						tensSec <= tensSec + 4'b1000;
						min <= min + 4'b0001;
					end
					else
					begin
						if (tensSec == 2)
						begin
							tensSec <= 4'b0;
							min <= min + 4'b0010;
						end
						else 
						begin
							if (tensSec == 3)
							begin
							tensSec <= 4'b0001;
							min <= min + 4'b0010;
							end
							else 
							begin
								if (tensSec == 4)
								begin
								tensSec <= 4'b0010;
								min <= min + 4'b0010;
								end
								else
								begin
									if (tensSec == 5)
									begin
										tensSec <= 4'b0011;
										min <= min + 4'b0010;
									end
									else
									begin
										if (tensSec == 6)
										begin
											tensSec <= 4'b0100;
											min <= min + 4'b0010;
										end
										else
										begin
											if (tensSec == 7)
											begin
												tensSec <= 4'b0101;
												min <= min + 4'b0010;
											end
											else
											begin
												if (tensSec == 8)
												begin
													tensSec <= 4'b0110;
													min <= min + 4'b0010;
												end
												else //tensSec == 9
												begin
													tensSec <= 4'b0111;
													min <= min + 4'b0010;
												end
											end
										end
									end
								end
							end
						end
					end
				end
				else //min = 9
				begin	
					if (tensMin < 9)
					begin
						min <= 4'b0;
						tensMin <= tensMin + 4'b0001;
					end
					else
					begin
						min <= 4'b1001;
						tensMin <= tensMin;
						tensSec <= 4'b1001;
						sec <= 4'b1001;
					end
				end
				//next_state <= COUNT_DOWN;
				add3Flag = 0;
			end
			else if (add4Flag == 1) //add 300 seconds
			begin
				if (min < 7)
				begin
					min <= min + 4'b0011;
				end
				else
				begin	
					if (tensMin < 9)
					begin
						if (min == 7)
						begin
							min <= 4'b0;
							tensMin <= tensMin + 4'b0001;
						end
						else 
						begin
							if (min == 8)
							begin
								min <= 4'b0;
								tensMin <= tensMin + 4'b0010;
							end
							else
							begin
								min <= 4'b0;
								tensMin <= tensMin + 4'b0011;
							end
						end
					end
					else
					begin
						min <= 4'b1001;
						tensMin <= 4'b1001;
					end
				end
				//next_state <= COUNT_DOWN;
				add4Flag = 0;
			end
			else if (rst1Flag == 1) //reset to 15 seconds
			begin
				tensMin <= 4'b0;
				min <= 4'b0;
				tensSec <= 4'b0001;
				sec <= 4'b0101;
				rst1Flag = 0;
				//next_state <= COUNT_DOWN;
			end
			else if (rst2Flag == 1) //reset to 150 seconds
			begin
				tensMin <= 4'b0;
				min <= 4'b0001;
				tensSec <= 4'b0101;
				sec <= 4'b0;
				rst2Flag = 0;
				//next_state <= COUNT_DOWN;
			end
			else
			begin	
				next_state <= COUNT_DOWN;
			end
		end
	COUNT_DOWN : begin //state 011
	
			if (tensMin == 4'b0000)
			begin
				if (min == 4'b0)
				begin
					if (tensSec == 4'b0)
					begin
						 if (sec == 4'b0)
							next_state <= INITIAL;
					end
				end	
			end
			else if (min == 4'b0)
			begin
				if (tensMin == 4'b0)
				begin
					if (tensSec == 4'b0)
					begin
						 if (sec == 4'b0)
							next_state <= INITIAL;
					end
				end	
			end
			else if (tensSec == 4'b0)
			begin
				if (min == 4'b0)
				begin
					if (tensMin == 4'b0)
					begin
						 if (sec == 4'b0)
							next_state <= INITIAL;
					end
				end	
			end
			else if (sec == 4'b0)
			begin
				if (min == 4'b0)
				begin
					if (tensSec == 4'b0)
					begin
						 if (tensMin == 4'b0)
							next_state <= INITIAL;
					end
				end	
			end
			else if (sec > 0)
			begin
				sec <= sec - 4'b0001;
			end
			else //sec == 0)
			begin
				
				sec <= 4'b1001;
				
				if (tensSec > 0)
				begin
					tensSec <= tensSec - 4'b0001;
				end
				else //tensSec == 0
				begin
					
					tensSec <= 4'b1001;
					
					if (min > 0)
					begin
						min <= min - 4'b0001;
					end
					else
					begin
					
						min <= 4'b1001;
						tensMin <= tensMin - 4'b0001;
						
						if (tensMin > 0)
						begin
							tensMin <= tensMin - 4'b0001;
						end
						else //tensMin == 0
						begin
							min <= 4'b1001;
						end
						
					end
				end
			end
			
			
			if (rstFlag == 1)
			begin
				next_state <= INITIAL;
			end
			else 
			begin
				if (add1Flag == 1)
				begin
					next_state <= ADD_TIME;
				end
				else if (tensMin == 4'b0000)
				begin
					if (min == 4'b0000)
					begin
						if (tensSec == 4'b0000)
						begin
							if (sec == 4'b0000)
								next_state <= INITIAL;//outFlag = 1;
						end
					end
				end
				else
				begin
					if (add2Flag == 1)
					begin
						next_state <= ADD_TIME;
					end
					else
					begin
						if (add3Flag == 1)
						begin
							next_state <= ADD_TIME;
						end
						else 
						begin
							if (add4Flag == 1)
							begin
								next_state <= ADD_TIME;
							end
							else
							begin
								if (rst1Flag == 1)
								begin
									next_state <= ADD_TIME;
								end
								else
								begin
									if (rst2Flag == 1)
									begin
										next_state <= ADD_TIME;
									end
									else
									begin
										next_state <= current_state;
									end
								end
							end
						end
					end
				end
			end
		end
	LOW_TIME : begin //state 100
			//do flashing here
		end
	default : begin
			next_state <= INITIAL;
		end
	endcase
endmodule

module outputMod(
	input wire [3:0] anodes,
	output wire [6:0] valOut
	);
	
	reg [6:0] tempSeg;
	
	always @ (*)
	case (anodes)
	4'b0000 : tempSeg = 7'b0000001;
	4'b0001 : tempSeg = 7'b1001111;
	4'b0010 : tempSeg = 7'b0010010;
	4'b0011 : tempSeg = 7'b0000110;
	4'b0100 : tempSeg = 7'b1001100;
	4'b0101 : tempSeg = 7'b0100100;
	4'b0110 : tempSeg = 7'b0100000;
	4'b0111 : tempSeg = 7'b0001111;
	4'b1000 : tempSeg = 7'b0000000;
	4'b1001 : tempSeg = 7'b0000100;
	default : tempSeg = 7'b0000001;
	endcase
	
	assign valOut = tempSeg;
endmodule

module modifiedClk (
	input wire clock,
	input wire reset,
	output reg clk_100hz
	);
	
	reg [19:0] counter;
	localparam const = 500000;
	
	always @ (posedge clock or posedge reset)
	begin
		if (reset)
			counter <= 20'b0;
		else if (counter == const - 1'b1)
			counter <= 20'b0;
		else
			counter <= counter + 1'b1;
	end

	always @ (posedge clock or posedge reset)
	begin
		if (reset)
			clk_100hz <= 1'b0;
		else if (counter == const - 1'b1)
			clk_100hz <= ~clk_100hz;
		else
			clk_100hz <= clk_100hz;
	end
endmodule

module blinkingClk2 ( //1 hz
	input wire clock,
	input wire reset,
	output reg blinkingClk2
	);
	
	reg [26:0] counter;
	localparam const = 50000000;
	
	always @ (posedge clock or posedge reset)
	begin
		if (reset)
			counter <= 0;
		else if (counter == const - 1)
			counter <= 27'b0;
		else
			counter <= counter + 1;
	end

	always @ (posedge clock or posedge reset)
	begin
		if (reset)
			blinkingClk2 <= 0;
		else if (counter == const - 1)
			blinkingClk2 <= ~blinkingClk2;
		else
			blinkingClk2 <= blinkingClk2;
	end

endmodule

module blinkingClk ( //.5 hz 
	input wire clock,
	input wire reset,
	output reg blinkingClk
	);
	
	reg [27:0] counter;
	localparam const = 100000000;
	
	always @ (posedge clock or posedge reset)
	begin
		if (reset)
			counter <= 28'b0;
		else if (counter == const - 1)
			counter <= 28'b0;
		else
			counter <= counter + 1;
	end

	always @ (posedge clock or posedge reset)
	begin
		if (reset)
			blinkingClk <= 0;
		else if (counter == const - 1)
			blinkingClk <= ~blinkingClk;
		else
			blinkingClk <= blinkingClk;
	end
endmodule
