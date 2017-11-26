module Comparator_Tree(
	input [15:0] DataIn_0, DataIn_1, DataIn_2, DataIn_3, DataIn_4, DataIn_5, 
	output [15:0] DataOut
);

	wire [15:0] layer_1[3:0];
	Comparator_D A0(DataIn_0, DataIn_1, layer_1[0]);
	Comparator_D A1(DataIn_2, DataIn_3, layer_1[1]);
	Comparator_D A2(DataIn_4, DataIn_5, layer_1[2]);
	
	wire [15:0] layer_2[1:0];
	Comparator_D B0(layer_1[0], layer_1[1], layer_2[0]);
	assign layer_2[1] = layer_1[2];
	
	Comparator_D C0(layer_2[0], layer_2[1], DataOut);
	
endmodule
