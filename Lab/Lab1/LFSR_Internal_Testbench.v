`timescale 1ns / 1ps

module LFSR_Internal_Testbench;

	// Inputs
	reg Clk;
	reg Reset;

	// Outputs
	wire Out;

	// Instantiate the Unit Under Test (UUT)
	LFSR_Internal uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.Out(Out)
	);
	
	always #5 Clk = ~Clk;

	initial begin
		// Initialize Inputs
		Clk = 1;
		Reset = 1;

		// Wait 100 ns for global reset to finish
		#5 Reset = 0;
        
		// Add stimulus here

	end
      
endmodule

