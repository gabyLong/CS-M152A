`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////// 
// Engineer:		Gabriella Long
//						605291133
// Create Date:   22:20:08 05/12/2020
// Design Name:   vending_machine
// Module Name:   /home/ise/Project4/testbench_605291133.v
// Project Name:  Project4
// Verilog Test Fixture created by ISE for module: vending_machine
// Revision:
// Revision 0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module testbench_605291133;

	// Inputs
 	reg CARD_IN;
	reg VALID_TRAN;
	reg [4:0] ITEM_CODE;
	reg KEY_PRESS;
	reg DOOR_OPEN;
	reg RELOAD;
	reg CLK;
	reg RESET;
	
	// Outputs
	wire VEND;
	wire INVALID_SEL;
	wire FAILED_TRAN;
	wire [2:0] COST;
	//wire [3:0] current_state;
	//wire [3:0] next_state;

	// Instantiate the Unit Under Test (UUT)
	vending_machine uut (
		.CARD_IN(CARD_IN),
		.VALID_TRAN(VALID_TRAN),
		.ITEM_CODE(ITEM_CODE),
		.KEY_PRESS(KEY_PRESS),
		.DOOR_OPEN(DOOR_OPEN),
		.RELOAD(RELOAD),
		.CLK(CLK),
		.RESET(RESET),
		.VEND(VEND),
		.INVALID_SEL(INVALID_SEL),
		.FAILED_TRAN(FAILED_TRAN),
		.COST(COST)
		//.current_state(current_state),
		//.next_state(next_state)
	);
	
	always #10 CLK = ~CLK;

	initial begin
		// Initialize Inputs
		CARD_IN = 0;
		VALID_TRAN = 0;
		ITEM_CODE = 0;
		DOOR_OPEN = 0;
		RELOAD = 0;
		CLK = 0;
		RESET = 0;
		KEY_PRESS = 0;
		
		////////////////////////////////////////
		//Test case #1
		#10
		RELOAD = 1;
		
		#10
		RELOAD = 0;
		////////////////////////////////////////
		//Test case #2
		#20;
		CARD_IN = 1;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1;
		#10
		KEY_PRESS = 0;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1;
		#10
		KEY_PRESS = 0;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1;
		#10
		VALID_TRAN = 1;
		#10 
		DOOR_OPEN = 1;
		#30
		DOOR_OPEN = 0;
		////////////////////////////////////////
		//Resetting inputs for next run
		CARD_IN = 0;
		VALID_TRAN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		////////////////////////////////////////
		//Test case #3
		#10
		CARD_IN = 1;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1;
		#10
		KEY_PRESS = 0;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1;
		#10
		KEY_PRESS = 0;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1;
		#10
		RESET = 1;
		////////////////////////////////////////
		//Resetting inputs for next run
		#20
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		////////////////////////////////////////
		//Test case #4
		#10
		CARD_IN = 1;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1 + 1'b1 + 1'b1 + 1'b1;
		#10
		VALID_TRAN = 1;
		DOOR_OPEN = 1;
		////////////////////////////////////////
		//Resetting inputs for next run
		#20
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		DOOR_OPEN = 0;
		VALID_TRAN = 0;
		////////////////////////////////////////
		//Test case #5
		#10
		CARD_IN = 1;
		VALID_TRAN = 0;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1 + 1'b1 + 1'b1;
		#30
		DOOR_OPEN = 1;
		////////////////////////////////////////
		//Resetting inputs for next run
		#20
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		DOOR_OPEN = 0;
		VALID_TRAN = 0;
		////////////////////////////////////////
		//Test case #6
		#70
		CARD_IN = 1;
		VALID_TRAN = 1;
		DOOR_OPEN = 1;
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		////////////////////////////////////////
		//Resetting inputs for next run
		#150
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		DOOR_OPEN = 0;
		VALID_TRAN = 0;
		////////////////////////////////////////
		//Test case #7
		#70
		CARD_IN = 1;
		VALID_TRAN = 1;
		DOOR_OPEN = 1;
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1 + 1'b1 + 1'b1;
		#10
		DOOR_OPEN = 0;
		////////////////////////////////////////
		//Resetting inputs for next run
		#150
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		VALID_TRAN = 0;
		////////////////////////////////////////
		//Test case #8
		#70
		CARD_IN = 1;
		VALID_TRAN = 1;
		DOOR_OPEN = 1;
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		////////////////////////////////////////
		//Resetting inputs for next run
		#150
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		VALID_TRAN = 0;
		DOOR_OPEN = 0;
		////////////////////////////////////////
		//Test case #9
		#70
		CARD_IN = 1;
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1;
		#10
		KEY_PRESS = 0;
		////////////////////////////////////////
		//Resetting inputs for next run
		#150
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		VALID_TRAN = 0;
		DOOR_OPEN = 0;
		////////////////////////////////////////
		//Test case #10
		#70
		CARD_IN = 1;
		VALID_TRAN = 1;
		DOOR_OPEN = 1;
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		#10
		KEY_PRESS = 0;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		////////////////////////////////////////
		//Resetting inputs for next run
		#150
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		VALID_TRAN = 0;
		DOOR_OPEN = 0;
		////////////////////////////////////////
		//Test case #11
		#70
		CARD_IN = 1;
		VALID_TRAN = 1;
		DOOR_OPEN = 1;
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		#10
		KEY_PRESS = 0;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		////////////////////////////////////////
		//Resetting inputs for next run
		//Test case #12, wait at idle until given input
		#150
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		VALID_TRAN = 0;
		DOOR_OPEN = 0;
		////////////////////////////////////////
		//Test case #13
		#100
		CARD_IN = 1;
		VALID_TRAN = 1;
		DOOR_OPEN = 1;
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		#10
		KEY_PRESS = 0;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1 + 1'b1 + 1'b1;
		////////////////////////////////////////
		//Resetting inputs for next run
		#500
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		VALID_TRAN = 0;
		DOOR_OPEN = 0;
		////////////////////////////////////////
		//Test case #14
		#100
		CARD_IN = 1;
		VALID_TRAN = 1;
		DOOR_OPEN = 1;
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		#10
		KEY_PRESS = 0;
		#10
		KEY_PRESS = 1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1 + 1'b1;
		#10
		ITEM_CODE <= ITEM_CODE + 1'b1 + 1'b1 + 1'b1;
		#100
		RESET = 1;
		#200
		RESET = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		VALID_TRAN = 0;
		DOOR_OPEN = 0;
		#2000 
		$finish;
	end 
endmodule

