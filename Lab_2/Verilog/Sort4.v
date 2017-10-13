module Sort4(
	input [11:0] DataIn_0, DataIn_1, DataIn_2, DataIn_3, 
	output [11:0] DataOut_0, DataOut_1, DataOut_2, DataOut_3
);

	wire [11:0] layer_1[3:0];
	Comparator_C A0(DataIn_0, DataIn_1, layer_1[0], layer_1[1]);
	Comparator_C A1(DataIn_2, DataIn_3, layer_1[2], layer_1[3]);
	
	wire [11:0] layer_2[3:0];
	Comparator_C B0(layer_1[0], layer_1[2], layer_2[0], layer_2[1]);
	Comparator_C B1(layer_1[1], layer_1[3], layer_2[2], layer_2[3]);
	
	assign DataOut_0 = layer_2[0];
	assign DataOut_3 = layer_2[3];
	Comparator_C C0(layer_2[1], layer_2[2], DataOut_1, DataOut_2);
	
endmodule