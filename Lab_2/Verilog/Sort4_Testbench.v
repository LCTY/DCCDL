`timescale 1ns / 1ps

module Sort4_Testbench;

	// Inputs
	reg [12:0] DataIn_0;
	reg [12:0] DataIn_1;
	reg [12:0] DataIn_2;
	reg [12:0] DataIn_3;

	// Outputs
	wire [7:0] DataOut_0;
	wire [7:0] DataOut_1;
	wire [7:0] DataOut_2;
	wire [7:0] DataOut_3;
	wire [4:0] Index_0, Index_1, Index_2, Index_3;

	// Instantiate the Unit Under Test (UUT)
	Sort4 uut (
		.DataIn_0(DataIn_0), 
		.DataIn_1(DataIn_1), 
		.DataIn_2(DataIn_2), 
		.DataIn_3(DataIn_3), 
		.DataOut_0({DataOut_0, Index_0}), 
		.DataOut_1({DataOut_1, Index_1}), 
		.DataOut_2({DataOut_2, Index_2}), 
		.DataOut_3({DataOut_3, Index_3})
	);

	initial begin
		// Initialize Inputs
		DataIn_0 = {8'd23, 5'd0};
		DataIn_1 = {8'd99, 5'd1};
		DataIn_2 = {8'd78, 5'd2};
		DataIn_3 = {8'd45, 5'd3};
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

