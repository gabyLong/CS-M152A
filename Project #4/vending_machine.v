`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 		 Gabriella Long
// 					
// Create Date:    22:19:23 05/12/2020 
// Design Name: 
// Module Name:    vending_machine 
// Project Name: 	 Project 4
// Revision: 
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module vending_machine(
	input wire CARD_IN,
	input wire VALID_TRAN,
	input wire [4:0] ITEM_CODE,
	input wire KEY_PRESS,
	input wire DOOR_OPEN,
	input wire RELOAD,
	input wire CLK,
	input wire RESET,
	output reg VEND,
	output reg INVALID_SEL,
	output reg FAILED_TRAN,
	output reg [2:0] COST
   //output reg [3:0] current_state, //remove for final sub
	//output reg [3:0] next_state //remove for final s
	);
	
	reg [2:0] current_state; 
	reg [2:0] next_state;
	reg [4:0] tempItemCode;
	reg [4:0] countToFive;
	reg [4:0] doorCount;
	reg [4:0] validCount;

	//vending machine item counters
	reg [3:0] snackCounter_0;
	reg [3:0] snackCounter_1;
	reg [3:0] snackCounter_2;
	reg [3:0] snackCounter_3;
	reg [3:0] snackCounter_4;
	reg [3:0] snackCounter_5;
	reg [3:0] snackCounter_6;
	reg [3:0] snackCounter_7;
	reg [3:0] snackCounter_8;
	reg [3:0] snackCounter_9;
	reg [3:0] snackCounter_10;
	reg [3:0] snackCounter_11;
	reg [3:0] snackCounter_12;
	reg [3:0] snackCounter_13;
	reg [3:0] snackCounter_14;
	reg [3:0] snackCounter_15;
	reg [3:0] snackCounter_16;
	reg [3:0] snackCounter_17;
	reg [3:0] snackCounter_18;
	reg [3:0] snackCounter_19;
		
	//vending items
	parameter [4:0] ITEM_00 = 5'b00000;
	parameter [4:0] ITEM_01 = 5'b00001;
	parameter [4:0] ITEM_02 = 5'b00010;
	parameter [4:0] ITEM_03 = 5'b00011;
	parameter [4:0] ITEM_04 = 5'b00100;
	parameter [4:0] ITEM_05 = 5'b00101;
	parameter [4:0] ITEM_06 = 5'b00110;
	parameter [4:0] ITEM_07 = 5'b00111;
	parameter [4:0] ITEM_08 = 5'b01000;
	parameter [4:0] ITEM_09 = 5'b01001;
	parameter [4:0] ITEM_10 = 5'b01010;
	parameter [4:0] ITEM_11 = 5'b01011;
	parameter [4:0] ITEM_12 = 5'b01100;
	parameter [4:0] ITEM_13 = 5'b01101;
	parameter [4:0] ITEM_14 = 5'b01110;
	parameter [4:0] ITEM_15 = 5'b01111;
	parameter [4:0] ITEM_16 = 5'b10000;
	parameter [4:0] ITEM_17 = 5'b10001;
	parameter [4:0] ITEM_18 = 5'b10010;
	parameter [4:0] ITEM_19 = 5'b10011;
	
	//states
	parameter [3:0] RESET_ = 4'b0000;
	parameter [3:0] IDLE = 4'b0001;
	parameter [3:0] CARD_INPUTTED = 4'b0010;
	parameter [3:0] TRANSACTION = 4'b0011;
	parameter [3:0] GET_ITEM_CODE = 4'b0100;
	parameter [3:0] CHECK_VALIDITY = 4'b0101;
	parameter [3:0] VEND_ITEM = 4'b0110;
	parameter [3:0] RELOAD_ITEMS = 4'b0111;
	parameter [3:0] FIVE_COUNT = 4'b1000;
	parameter [3:0] GET_COST = 4'b1001;
	parameter [3:0] DOOR_COUNT = 4'b1010;
	parameter [3:0] VALID_COUNT = 4'b1011;
	
	//cost of items
	parameter [2:0] costFor0_1_2_3 = 3'b001;
	parameter [2:0] costFor4_5_6_7 = 3'b010;
	parameter [2:0] costFor8_9_10_11 = 3'b011;
	parameter [2:0] costFor12_13_14_15 = 3'b100;
	parameter [2:0] costFor16_17 = 3'b101;
	parameter [2:0] costFor18_19 = 3'b110;
	
	//next state movement
	always @ (posedge CLK)
	begin
		if (RESET)
		begin
			current_state <= RESET_;
		end
		else
			current_state <= next_state;
	end
	
	reg doorFlag;
	reg resetFlag;
	
	//to trigger transition to IDLE state after everything is said and done
	always @ (negedge DOOR_OPEN)
	begin
		if (DOOR_OPEN)
			doorFlag <= 1;
		else 
			doorFlag <= 0;
	end
	
	//state determination
	always @ (*)
	case (current_state)
	RESET_ : begin //state 0000
			VEND <= 0;
			INVALID_SEL <= 0;
			FAILED_TRAN <= 0;
			COST <= 3'b000;
			snackCounter_0 <= 4'b0000;
			snackCounter_1 <= 4'b0000;
			snackCounter_2 <= 4'b0000;
			snackCounter_3 <= 4'b0000;
			snackCounter_4 <= 4'b0000;
			snackCounter_5 <= 4'b0000;
			snackCounter_6 <= 4'b0000;
			snackCounter_7 <= 4'b0000;
			snackCounter_8 <= 4'b0000;
			snackCounter_9 <= 4'b0000;
			snackCounter_10 <= 4'b0000;
			snackCounter_11 <= 4'b0000;
			snackCounter_12 <= 4'b0000;
			snackCounter_13 <= 4'b0000;
			snackCounter_14 <= 4'b0000;
			snackCounter_15 <= 4'b0000;
			snackCounter_16 <= 4'b0000;
			snackCounter_17 <= 4'b0000;
			snackCounter_18 <= 4'b0000;
			snackCounter_19 <= 4'b0000;
			
			if (RESET == 0)
			begin
				next_state = IDLE;
				//current_state <= RESET_;
			end
			else
				next_state = current_state;
		end
	IDLE : begin //state 0001
			VEND <= 0;
			COST <= 3'b000;
			INVALID_SEL <= 0;
			FAILED_TRAN <= 0;
			
			if (RELOAD == 1'b1)
			begin
				next_state = RELOAD_ITEMS;//3'b011;
			end
			else if (CARD_IN == 1)
			begin
				next_state = CARD_INPUTTED;
			end
			else if (RESET == 1)
			begin
				next_state = RESET_;
			end
			else if (KEY_PRESS == 1)
			begin
				if (countToFive < 5) 
					next_state = GET_ITEM_CODE;
				else 
					next_state = FIVE_COUNT;
					//countToFive <= countToFive + 1;
			end
			else
			begin
				next_state = current_state;
			end
		end
	CARD_INPUTTED : begin //state 0010
			if (RESET == 1)
				next_state = RESET_;
			else
				next_state = GET_ITEM_CODE;
		end
	TRANSACTION : begin //state 0011
			if (RESET == 1)
				next_state = RESET_;
			else if (VALID_TRAN == 1)
				next_state = VEND_ITEM;
			else if (VALID_TRAN == 0)
			begin
				if (INVALID_SEL == 0)
				begin
					next_state = VALID_COUNT;
					if (validCount > 4)
						next_state = IDLE;
						FAILED_TRAN <= 1;
				end
			end	
		end
	GET_ITEM_CODE : begin //state 0100
			if (KEY_PRESS == 0)
				next_state = FIVE_COUNT;
			else if (countToFive >= 5'b00101)
			begin
				next_state = IDLE;
				//countToFive <= 5'b00000;
			end
			else if (RESET == 1)
				next_state = RESET_;
			else
				next_state = GET_COST;
			//end
		end
	GET_COST : begin //state 1001
			if (ITEM_CODE == 5'b00000)
				COST <= costFor0_1_2_3;
			else if (ITEM_CODE == 5'b00001)
				COST <= costFor0_1_2_3;
			else if (ITEM_CODE == 5'b00010)
				COST <= costFor0_1_2_3;
			else if (ITEM_CODE == 5'b00011)
				COST <= costFor0_1_2_3;
			else if (ITEM_CODE == 5'b00100)
				COST <= costFor4_5_6_7;
			else if (ITEM_CODE == 5'b00101)
				COST <= costFor4_5_6_7;
			else if (ITEM_CODE == 5'b00110)
				COST <= costFor4_5_6_7;
			else if (ITEM_CODE == 5'b00111)
				COST <= costFor4_5_6_7;
			else if (ITEM_CODE == 5'b01000)
				COST <= costFor8_9_10_11;
			else if (ITEM_CODE == 5'b01001)
				COST <= costFor8_9_10_11;
			else if (ITEM_CODE == 5'b01010)
				COST <= costFor8_9_10_11;
			else if (ITEM_CODE == 5'b01011)
				COST <= costFor8_9_10_11;
			else if (ITEM_CODE == 5'b01100)
				COST <= costFor12_13_14_15;
			else if (ITEM_CODE == 5'b01101)
				COST <= costFor12_13_14_15;
			else if (ITEM_CODE == 5'b01110)
				COST <= costFor12_13_14_15;
			else if (ITEM_CODE == 5'b01111)
				COST <= costFor12_13_14_15;
			else if (ITEM_CODE == 5'b10000)
				COST <= costFor16_17;
			else if (ITEM_CODE == 5'b10001)
				COST <= costFor16_17;
			else if (ITEM_CODE == 5'b10010)
				COST <= costFor18_19;
			else if (ITEM_CODE == 5'b10011)
				COST <= costFor18_19;
			else
				COST <= 0;
				
			if (RESET == 1)
				next_state = RESET_;
			else	
				next_state = CHECK_VALIDITY;
		end
	CHECK_VALIDITY : begin //state 0101
			//next_state <= VEND_ITEM;
			if (ITEM_CODE == 5'b00000)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b00001)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b00010)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b00011)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b00100)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b00101)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b00110)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b00111)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b01000)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b01001)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b01010)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b01011)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b01100)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b01101)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b01110)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b01111)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b10000)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b10001)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b10010)
				INVALID_SEL <= 0;
			else if (ITEM_CODE == 5'b10011)
				INVALID_SEL <= 0;
			else
			begin
				INVALID_SEL <= 1;	
				next_state = IDLE;
			end
			next_state = TRANSACTION;
		end
	VEND_ITEM : begin //state 0110
		/*
			if (ITEM_CODE == 5'b00000)
			begin
				snackCounter_0 <= snackCounter_0 - 1'b1;
				VEND <= 1;
			end	
			else 
			begin
				if (ITEM_CODE == 5'b00001)
				begin
					snackCounter_1 <= snackCounter_1 - 1'b1;
					VEND <= 1;
				end
				else
				begin
					if (ITEM_CODE == 5'b00010)
					begin
						snackCounter_2 <= snackCounter_2 - 1'b1;
						VEND <= 1;
					end
					else
					begin
						if (ITEM_CODE == 5'b00011)
						begin
							snackCounter_3 <= snackCounter_3 - 1'b1;
							VEND <= 1;
						end
						else
						begin
							if (ITEM_CODE == 5'b00100)
							begin
								snackCounter_4 <= snackCounter_4 - 1'b1;
								VEND = 1;
							end
							else
							begin
								if (ITEM_CODE == 5'b00101)
								begin
									snackCounter_5 <= snackCounter_5 - 1'b1;
									VEND <= 1;
								end
								else
								begin
									if (ITEM_CODE == 5'b00110)
									begin
										snackCounter_6 <= snackCounter_6 - 1'b1;
										VEND <= 1;
									end
									else
									begin
										if (ITEM_CODE == 5'b00111)
										begin
											snackCounter_7 <= snackCounter_7 - 1'b1;
											VEND <= 1;
										end
										else
										begin
											if (ITEM_CODE == 5'b01000)
											begin
												snackCounter_8 <= snackCounter_8 - 1'b1;
												VEND <= 1;
											end
											else
											begin
												if (ITEM_CODE == 5'b01001)
												begin
													snackCounter_9 <= snackCounter_9 - 1'b1;
													VEND <= 1;
												end
												else
												begin
													if (ITEM_CODE == 5'b01010)
													begin
														snackCounter_10 <= snackCounter_10 - 1'b1;
														VEND <= 1;
													end
													else
													begin
														if (ITEM_CODE == 5'b01011)
														begin
															snackCounter_11 <= snackCounter_11 - 1'b1;
															VEND <= 1;
														end
														else
														begin
															if (ITEM_CODE == 5'b01100)
															begin
																snackCounter_12 <= snackCounter_12 - 1'b1;
																VEND <= 1;
															end
															else
															begin
																if (ITEM_CODE == 5'b01101)
																begin
																	snackCounter_13 <= snackCounter_13 - 1'b1;
																	VEND <= 1;
																end
																else
																begin
																	if (ITEM_CODE == 5'b01110)
																	begin
																		snackCounter_14 <= snackCounter_14 - 1'b1;
																		VEND <= 1;
																	end
																	else
																	begin
																		if (ITEM_CODE == 5'b01111)
																		begin
																			snackCounter_15 <= snackCounter_15 - 1'b1;
																			VEND <= 1;
																		end
																		else
																		begin
																			if (ITEM_CODE == 5'b10000)
																			begin
																				snackCounter_16 <= snackCounter_16 - 1'b1;
																				VEND <= 1;
																			end
																			else
																			begin
																				if (ITEM_CODE == 5'b10001)
																				begin
																					snackCounter_17 <= snackCounter_17 - 1'b1;
																					VEND <= 1;
																				end
																				else
																				begin
																					if (ITEM_CODE == 5'b10010)
																					begin
																						snackCounter_18 <= snackCounter_18 - 1'b1;
																						VEND <= 1;
																					end
																					else
																					begin
																						if (ITEM_CODE == 5'b10011)
																						begin
																							snackCounter_19 <= snackCounter_19 - 1'b1;
																							VEND <= 1;
																						end
																						else
																							VEND <= 0;
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
											end
										end
									end
								end
							end
						end
					end
				end
			end
			*/
			
			if (INVALID_SEL == 0)
			begin
				VEND <= 1;
				if (doorFlag == 1)
				begin
					next_state = IDLE;
				end
				else 
				begin
					if (DOOR_OPEN == 0)
					begin
						next_state = DOOR_COUNT;
						if (doorCount > 4)
							next_state = IDLE;
					end
				end
			end
			
			if (RESET == 1)
				next_state = RESET_;
			else
				next_state = IDLE;
		end
	RELOAD_ITEMS : begin //state 0111
			snackCounter_1 <= 4'b1010;
			snackCounter_2 <= 4'b1010;
			snackCounter_3 <= 4'b1010;
			snackCounter_4 <= 4'b1010;
			snackCounter_5 <= 4'b1010;
			snackCounter_6 <= 4'b1010;
			snackCounter_7 <= 4'b1010;
			snackCounter_8 <= 4'b1010;
			snackCounter_9 <= 4'b1010;
			snackCounter_10 <= 4'b1010;
			snackCounter_11 <= 4'b1010;
			snackCounter_12 <= 4'b1010;
			snackCounter_13 <= 4'b1010;
			snackCounter_14 <= 4'b1010;
			snackCounter_15 <= 4'b1010;
			snackCounter_16 <= 4'b1010;
			snackCounter_17 <= 4'b1010;
			snackCounter_18 <= 4'b1010;
			snackCounter_19 <= 4'b1010;
			
			if (RESET == 1)
				next_state = RESET_;
			else
				next_state = IDLE;
		end
	FIVE_COUNT : begin
			//countToFive <= countToFive + 1'b1;
			if (KEY_PRESS == 0)
			begin
				countToFive <= countToFive + 1'b1;
				next_state = IDLE;
			end
			else
				next_state = IDLE;
		end
	DOOR_COUNT : begin
			if (DOOR_OPEN == 0)
			begin
				doorCount <= doorCount + 1'b1;
				if (doorCount < 5)
					next_state = VEND_ITEM;
				else
					next_state = IDLE;
			end
			else if (doorCount > 4)
				next_state = IDLE;
			else
				next_state = current_state;
		end
	VALID_COUNT : begin
			if (VALID_TRAN == 0)
			begin
				validCount = validCount + 1'b1;
				if (validCount < 5)
					next_state = TRANSACTION;
				else
					next_state = IDLE;
			end
			else if (validCount > 4)
			begin
				next_state = IDLE;
				FAILED_TRAN <= 1;
			end
			else
				next_state = current_state; 
		end
	default : begin
			next_state = IDLE;
		end
	endcase
endmodule

