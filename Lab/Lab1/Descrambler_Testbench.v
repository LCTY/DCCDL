`timescale 1ns / 1ps

module Descrambler_Testbench;

	// Inputs
	reg Clk;
	reg Reset;
	reg D2;

	// Outputs
	wire Out;

	// Instantiate the Unit Under Test (UUT)
	Descrambler uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.D2(D2), 
		.Out(Out)
	);

	always #5 Clk = ~Clk;

	initial begin
		// Initialize Inputs
		Clk = 1;
		Reset = 1;
		D2 = 1;
		// 1 0 0 1 1 0 0 0 1 1 1 1 0 0 1 0 0 0 1 0 0 1 1 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0

		// Wait 100 ns for global reset to finish
		#5 Reset = 0;
		#10 D2 = 0;
		#10 D2 = 1;
		#30 D2 = 0;
		#10 D2 = 1;
		#10 D2 = 0;
		#10 D2 = 1;
		#10 D2 = 0;
		#20 D2 = 1;
		#20 D2 = 0;
		#30 D2 = 1;
		
		#40 D2 = 0;
		#20 D2 = 1;
		#10 D2 = 0;
		#30 D2 = 1;
		#10 D2 = 0;
		#20 D2 = 1;
		#20 D2 = 0;
		
		#30 D2 = 1;
		#40 D2 = 0;
		#40 D2 = 1;
		#40 D2 = 0;
        
		// Add stimulus here

	end
      
endmodule

