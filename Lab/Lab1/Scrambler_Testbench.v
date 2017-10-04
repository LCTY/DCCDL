`timescale 1ns / 1ps

module Scrambler_Testbench;

	// Inputs
	reg Clk;
	reg Reset;
	reg D1;

	// Outputs
	wire Out;

	// Instantiate the Unit Under Test (UUT)
	Scrambler uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.D1(D1), 
		.Out(Out)
	);

	always #5 Clk = ~Clk;

	initial begin
		// Initialize Inputs
		Clk = 1;
		Reset = 1;
		D1 = 1;
		//1 1 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 1 1

		// Wait 100 ns for global reset to finish
		#5 Reset = 0;
		#80 D1 = 0;
		#40 D1 = 1;
		#120 D1 = 0;
		#40 D1 = 1;
		#120 D1 = 0;
		#40 D1 = 1;
        
		// Add stimulus here

	end
      
endmodule

