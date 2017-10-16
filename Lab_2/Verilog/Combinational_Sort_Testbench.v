`timescale 1ns / 1ps

module Combinational_Sort_Testbench;

	// Inputs
	reg [11:0] DataIn_0, DataIn_1, DataIn_2, DataIn_3, DataIn_4, DataIn_5, DataIn_6, DataIn_7, DataIn_8, DataIn_9, DataIn_10, DataIn_11;

	// Outputs
	wire [11:0] DataOut;
	wire [7:0] Value;
	wire [3:0] Index;
	assign {Value, Index} = DataOut;

	// Instantiate the Unit Under Test (UUT)
	Combinational_Sort uut (
		.DataIn_0(DataIn_0), 
		.DataIn_1(DataIn_1), 
		.DataIn_2(DataIn_2), 
		.DataIn_3(DataIn_3), 
		.DataIn_4(DataIn_4), 
		.DataIn_5(DataIn_5), 
		.DataIn_6(DataIn_6), 
		.DataIn_7(DataIn_7), 
		.DataIn_8(DataIn_8), 
		.DataIn_9(DataIn_9), 
		.DataIn_10(DataIn_10), 
		.DataIn_11(DataIn_11), 
		.DataOut(DataOut)
	);

	initial begin
		// Initialize Inputs
		DataIn_0 =	{8'd15,	4'd0};
		DataIn_1 =	{8'd67,	4'd1};
		DataIn_2 =	{8'd242,4'd2};
		DataIn_3 =	{8'd231,4'd3};
		DataIn_4 =	{8'd169,4'd4};
		DataIn_5 =	{8'd24,	4'd5};
		DataIn_6 =	{8'd105,4'd6};
		DataIn_7 =	{8'd125,4'd7};
		DataIn_8 =	{8'd224,4'd8};
		DataIn_9 =	{8'd71,	4'd9};
		DataIn_10 =	{8'd165,4'd10};
		DataIn_11 =	{8'd225,4'd11};

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

