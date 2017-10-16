`timescale 1ns / 1ps

module SelectTop6_Testbench;

	// Inputs
	reg Clk, Reset;
	reg [12:0] DataIn_0, DataIn_1, DataIn_2, DataIn_3, DataIn_4, DataIn_5, DataIn_6, DataIn_7, DataIn_8, DataIn_9, DataIn_10, DataIn_11, DataIn_12, DataIn_13, DataIn_14, DataIn_15, DataIn_16, DataIn_17, DataIn_18, DataIn_19, DataIn_20, DataIn_21, DataIn_22, DataIn_23;

	// Outputs
	wire [15:0] DataOut;
	wire [7:0] Value;
	wire [4:0] Index;
	wire [2:0] GroupNumber;
	
	assign {Value, Index, GroupNumber} = DataOut;

	// Instantiate the Unit Under Test (UUT)
	SelectTop6 uut (
		.Clk(Clk), 
		.Reset(Reset), 
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
		.DataIn_12(DataIn_12), 
		.DataIn_13(DataIn_13), 
		.DataIn_14(DataIn_14), 
		.DataIn_15(DataIn_15), 
		.DataIn_16(DataIn_16), 
		.DataIn_17(DataIn_17), 
		.DataIn_18(DataIn_18), 
		.DataIn_19(DataIn_19), 
		.DataIn_20(DataIn_20), 
		.DataIn_21(DataIn_21), 
		.DataIn_22(DataIn_22), 
		.DataIn_23(DataIn_23), 
		.DataOut(DataOut)
	);
	
	always #20 Clk = ~Clk;

	initial begin
		// Initialize Inputs
		Clk = 1;
		Reset = 1;
		
		DataIn_0 = {8'd245, 5'd0};
		DataIn_1 = {8'd40, 5'd1};
		DataIn_2 = {8'd245, 5'd2};
		DataIn_3 = {8'd204, 5'd3};
		
		DataIn_4 = {8'd107, 5'd4};
		DataIn_5 = {8'd202, 5'd5};
		DataIn_6 = {8'd167, 5'd6};
		DataIn_7 = {8'd217, 5'd7};
		
		DataIn_8 = {8'd173, 5'd8};
		DataIn_9 = {8'd190, 5'd9};
		DataIn_10 = {8'd167, 5'd10};
		DataIn_11 = {8'd180, 5'd11};
		
		DataIn_12 = {8'd70, 5'd12};
		DataIn_13 = {8'd24, 5'd13};
		DataIn_14 = {8'd177, 5'd14};
		DataIn_15 = {8'd243, 5'd15};
		
		DataIn_16 = {8'd112, 5'd16};
		DataIn_17 = {8'd195, 5'd17};
		DataIn_18 = {8'd47, 5'd18};
		DataIn_19 = {8'd114, 5'd19};
		
		DataIn_20 = {8'd181, 5'd20};
		DataIn_21 = {8'd70, 5'd21};
		DataIn_22 = {8'd167, 5'd22};
		DataIn_23 = {8'd30, 5'd23};

		// Wait 100 ns for global reset to finish
		#100; Reset = 0;
		
		#220; $finish;
        
		// Add stimulus here

	end
      
endmodule

