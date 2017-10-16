`timescale 1ns / 1ps

module Sequential_Sort_Testbench;

	// Inputs
	reg Clk, Reset;
	reg [11:0] DataIn;

	// Outputs
	wire [11:0] DataOut;
	wire [7:0] Value;
	wire [3:0] Index;
	assign {Value, Index} = DataOut;

	// Instantiate the Unit Under Test (UUT)
	Sequential_Sort uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.DataIn(DataIn), 
		.DataOut(DataOut)
	);
	always #10 Clk = ~Clk;

	initial begin
		// Initialize Inputs
		Clk = 1;
		Reset = 1;
		DataIn = {8'd246, 4'd0};

		// Wait 100 ns for global reset to finish
		#90; Reset = 0;
		#20; DataIn = {8'd64, 4'd1};
		#20; DataIn = {8'd234, 4'd2};
		#20; DataIn = {8'd82, 4'd3};
		#20; DataIn = {8'd104, 4'd4};
		#20; DataIn = {8'd151, 4'd5};
		#20; DataIn = {8'd141, 4'd6};
		#20; DataIn = {8'd229, 4'd7};
		#20; DataIn = {8'd198, 4'd8};
		#20; DataIn = {8'd142, 4'd9};
		#20; DataIn = {8'd140, 4'd10};
		#20; DataIn = {8'd123, 4'd11};
		
		#30; $finish;
        
		// Add stimulus here

	end
      
endmodule

