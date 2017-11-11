`timescale 1ns / 1ps

module Unit_Stage_A_Testbench;

	// Inputs
	reg signed [14:0] X;
	reg signed [14:0] Y;
	reg signed [15:0] Theta;
	reg signed [15:0] Theta_element;

	// Outputs
	wire signed [14:0] X_out;
	wire signed [14:0] Y_out;
	wire signed [15:0] Theta_out;

	// Instantiate the Unit Under Test (UUT)
	Unit_Stage_A#(4) uut (
		.X(X), 
		.Y(Y), 
		.Theta(Theta), 
		.Theta_element(Theta_element), 
		.X_out(X_out), 
		.Y_out(Y_out), 
		.Theta_out(Theta_out)
	);

	initial begin
	
	/*	// Stage 0
		X = 15'd7616;
		Y = 15'd3008;
		Theta = 16'd0;
		Theta_element = 16'd12867;
		
		// Stage 1
		X = 15'sd10624;
		Y = -15'sd4608;
		Theta = 16'sd12867;
		Theta_element = 16'd7596;
		
		// Stage 2
		X = 15'sd12928;
		Y = 15'sd704;
		Theta = 16'sd5271;
		Theta_element = 16'd4013;
		
		// Stage 3
		X = 15'd13104;
		Y = -15'd2528;
		Theta = 16'd9284;
		Theta_element = 16'd2037;
		
		// Stage 4
		X = 15'd13420;
		Y = -15'd890;
		Theta = 16'd7247;
		Theta_element = 16'd1022;*/
	end
      
endmodule

