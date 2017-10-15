module SelectTop6(
	input Clk, Reset, 
	input [12:0] DataIn_0, DataIn_1, DataIn_2, DataIn_3, DataIn_4, DataIn_5, DataIn_6, DataIn_7, DataIn_8, DataIn_9, DataIn_10, DataIn_11, DataIn_12, DataIn_13, DataIn_14, DataIn_15, DataIn_16, DataIn_17, DataIn_18, DataIn_19, DataIn_20, DataIn_21, DataIn_22, DataIn_23, 
	output [15:0] DataOut
);

	wire [12:0] layer_1[23:0];
	wire [12:0] layer_2[5:0];
	wire [1:0] select_0, select_1, select_2, select_3, select_4, select_5;
	Sort4 A0(DataIn_0, DataIn_1, DataIn_2, DataIn_3, layer_1[0], layer_1[1], layer_1[2], layer_1[3]);
	Mux4 A1(layer_1[0], layer_1[1], layer_1[2], layer_1[3], select_0, layer_2[0]);
	
	Sort4 B0(DataIn_4, DataIn_5, DataIn_6, DataIn_7, layer_1[4], layer_1[5], layer_1[6], layer_1[7]);
	Mux4 B1(layer_1[4], layer_1[5], layer_1[6], layer_1[7], select_1, layer_2[1]);
	
	Sort4 C0(DataIn_8, DataIn_9, DataIn_10, DataIn_11, layer_1[8], layer_1[9], layer_1[10], layer_1[11]);
	Mux4 C1(layer_1[8], layer_1[9], layer_1[10], layer_1[11], select_2, layer_2[2]);
	
	Sort4 D0(DataIn_12, DataIn_13, DataIn_14, DataIn_15, layer_1[12], layer_1[13], layer_1[14], layer_1[15]);
	Mux4 D1(layer_1[12], layer_1[13], layer_1[14], layer_1[15], select_3, layer_2[3]);
	
	Sort4 E0(DataIn_16, DataIn_17, DataIn_18, DataIn_19, layer_1[16], layer_1[17], layer_1[18], layer_1[19]);
	Mux4 E1(layer_1[16], layer_1[17], layer_1[18], layer_1[19], select_4, layer_2[4]);
	
	Sort4 F0(DataIn_20, DataIn_21, DataIn_22, DataIn_23, layer_1[20], layer_1[21], layer_1[22], layer_1[23]);
	Mux4 F1(layer_1[20], layer_1[21], layer_1[22], layer_1[23], select_5, layer_2[5]);
	
	Comparator_Tree U0({layer_2[0], 3'd0}, {layer_2[1], 3'd1}, {layer_2[2], 3'd2}, {layer_2[3], 3'd3}, {layer_2[4], 3'd4}, {layer_2[5], 3'd5}, DataOut);
	
	Control_Unit U1(Clk, Reset, DataOut[2:0], select_0, select_1, select_2, select_3, select_4, select_5);
	
endmodule