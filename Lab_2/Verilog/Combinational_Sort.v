module Combinational_Sort(
	input [11:0] DataIn_0, DataIn_1, DataIn_2, DataIn_3, DataIn_4, DataIn_5, DataIn_6, DataIn_7, DataIn_8, DataIn_9, DataIn_10, DataIn_11, 
	output [11:0] DataOut
);

	wire [11:0] layer_1[5:0];
	Comparator_B A0(DataIn_0, DataIn_1, layer_1[0]);
	Comparator_B A1(DataIn_2, DataIn_3, layer_1[1]);
	Comparator_B A2(DataIn_4, DataIn_5, layer_1[2]);
	Comparator_B A3(DataIn_6, DataIn_7, layer_1[3]);
	Comparator_B A4(DataIn_8, DataIn_9, layer_1[4]);
	Comparator_B A5(DataIn_10, DataIn_11, layer_1[5]);
	
	wire [11:0] layer_2[2:0];
	Comparator_B B0(layer_1[0], layer_1[1], layer_2[0]);
	Comparator_B B1(layer_1[2], layer_1[3], layer_2[1]);
	Comparator_B B2(layer_1[4], layer_1[5], layer_2[2]);
	
	wire [11:0] layer_3[1:0];
	Comparator_B C0(layer_2[0], layer_2[1], layer_3[0]);
	assign layer_3[1] = layer_2[2];
	
	Comparator_B D0(layer_3[0], layer_3[1], DataOut);
	
endmodule