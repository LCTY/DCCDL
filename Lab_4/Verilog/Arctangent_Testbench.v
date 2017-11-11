`timescale 1ns / 1ps

module Arctangent_Testbench;

	// Inputs
	reg Clk;
	reg Reset;
	reg signed [11:0] X;
	reg signed [11:0] Y;

	// Outputs
	wire [16:0] Theta;

	// Instantiate the Unit Under Test (UUT)
	Arctangent uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.X(X), 
		.Y(Y), 
		.Theta(Theta)
	);
	
	reg signed [12-1:0] X_array [9:0];
	reg signed [12-1:0] Y_array [9:0];
	initial begin
		X_array[0] = 12'd952;
		X_array[1] = 12'd548;
		X_array[2] = -12'd65;
		X_array[3] = -12'd653;
		X_array[4] = -12'd992;
		X_array[5] = -12'd953;
		X_array[6] = -12'd549;
		X_array[7] = 12'd64;
		X_array[8] = 12'd652;
		X_array[9] = 12'd991;
		
		Y_array[0] = 12'd376;
		Y_array[1] = 12'd864;
		Y_array[2] = 12'd1021;
		Y_array[3] = 12'd789;
		Y_array[4] = 12'd254;
		Y_array[5] = -12'd377;
		Y_array[6] = -12'd865;
		Y_array[7] = -12'd1022;
		Y_array[8] = -12'd790;
		Y_array[9] = -12'd255;
	end
	
	always #20 Clk = ~Clk;
	
	reg rst;
	reg [4-1:0] count;
	always @(posedge Clk or posedge rst) begin
		if (rst) begin
			count <= 0;
			X <= 0;
			Y <= 0;
		end
		else begin
			#6.5;
			X <= X_array[count];
			Y <= Y_array[count];
			count <= count + 1'b1;
		end
	end

	initial begin
		// Initialize Inputs
		Clk = 1;
		rst = 1;
		Reset = 1;
		#80; rst = 0;
		#6.5; Reset = 0;
	end
      
endmodule
