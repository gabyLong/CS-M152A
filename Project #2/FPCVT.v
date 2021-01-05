`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:			Gabriella Long
//							
// 
// Create Date:		01:14:24 04/22/2020 
// Design Name: 
// Module Name:		FPCVT 
// Project Name: 		Project 2
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module FPCVT(
	input wire [12:0] D,
	output wire S,
	output wire [2:0] E,
	output wire [4:0] F
	);
	
	wire [12:0] dBetweenMods;
	wire [2:0] eBetweenMods;
	wire [4:0] fBetweenMods;
	wire sixthSig; //need for rounding
	
	
	block1 b1(.dInput(D), .dOutput(dBetweenMods),.sOutput(S));
	
	block2 b2(.dInput(dBetweenMods), .eOutput(eBetweenMods), .fOutput(fBetweenMods), .sigSix(sixthSig));
	
	block3 b3(.fInput(fBetweenMods), .sixthS(sixthSig), .eInput(eBetweenMods), .fOutput(F), .eOutput(E));
endmodule

module block1(
	input [12:0] dInput,
	output reg [12:0] dOutput,
	output sOutput
	);

	always @ (*)
	begin
		if (dInput[12] == 1)
			dOutput = ~dInput + 1'b1;
		else
			dOutput = dInput;
	end
	
	assign sOutput = dInput[12];
endmodule

module block2(
	input wire [12:0] dInput, 
	output reg [2:0] eOutput, 
	output reg [4:0] fOutput,
	output reg sigSix
	);
	
	always @ (*)
	begin
		if (dInput[12] == 1)
			eOutput = 3'b111;
		else
		begin
			if (dInput[11] == 1)
				eOutput = 3'b111;
			else
			begin
				if (dInput[10] == 1)
					eOutput = 3'b110;
				else
				begin
					if (dInput[9] == 1)
						eOutput = 3'b101;
					else
					begin
						if (dInput[8] == 1)
							eOutput = 3'b100;
						else
						begin
							if (dInput[7] == 1)
								eOutput = 3'b011;
							else
							begin
								if (dInput[6] == 1)
									eOutput = 3'b010;
								else
								begin
									if (dInput[5] == 1)
										eOutput = 3'b001;
									else
										eOutput = 3'b000;
								end
							end
						end
					end
				end
			end
		end
	end
	
	always @ (*)
	begin
		if (dInput[12] == 1)
			fOutput = 4'b1111;
		else
		begin
			if (dInput[11] == 1)
				fOutput = dInput[11:7];
			else
			begin
				if (dInput[10] == 1)
					fOutput = dInput[10:6];
				else
				begin
					if (dInput[9] == 1)
						fOutput = dInput[9:5];
					else
					begin
						if (dInput[8] == 1)
							fOutput = dInput[8:4];
						else
						begin
							if (dInput[7] == 1)
								fOutput = dInput[7:3];
							else
							begin
								if (dInput[6] == 1)
									fOutput = dInput[6:2];
								else
								begin
									if (dInput[5] == 1)
										fOutput = dInput[5:1];
									else
										fOutput = dInput[4:0];
								end
							end
						end
					end
				end
			end
		end
	end

	always @ (*)
	begin
		if (dInput[12] == 1)
			sigSix = 1;
		else
		begin
			if (dInput[11] == 1)
				sigSix = dInput[6];
			else
			begin
				if (dInput[10] == 1)
					sigSix = dInput[5];
				else
				begin
					if (dInput[9] == 1)
						sigSix = dInput[4];
					else
					begin
						if (dInput[8] == 1)
							sigSix = dInput[3];
						else
						begin
							if (dInput[7] == 1)
								sigSix = dInput[2];
							else
							begin
								if (dInput[6] == 1)
									sigSix = dInput[1];
								else
								begin
									if (dInput[5] == 1)
										sigSix = dInput[0];
									else
										sigSix = 0;
								end
							end
						end
					end
				end
			end
		end
	end 
endmodule

module block3(
	input [4:0] fInput,
	input wire sixthS,
	input [2:0] eInput,
	output reg [4:0] fOutput,
	output reg [2:0] eOutput
	);
	
	always @ (*) 
	begin
		if (sixthS == 1)
		begin
			if (fInput == 5'b11111)
			begin
				if (eInput == 3'b111)
				begin
					eOutput = 3'b111;
					fOutput = 5'b11111;
				end
				else
				begin
					eOutput = eInput + 1;
					fOutput = 5'b10000;
				end
			end
			else
			begin
				eOutput = eInput;
				fOutput = fInput + 1;
			end
		end
		else
		begin //no rounding required
			fOutput = fInput;
			eOutput = eInput;
		end
	end
endmodule

