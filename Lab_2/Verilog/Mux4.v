module Mux4(
	input [12:0] DataIn_0, DataIn_1, DataIn_2, DataIn_3, 
	input [1:0] Select, 
	output reg [12:0] DataOut
);

	always @(*) begin
		if (Select == 2'd0)
			DataOut = DataIn_0;
		else if (Select == 2'd1)
			DataOut = DataIn_1;
		else if (Select == 2'd2)
			DataOut = DataIn_2;
		else
			DataOut = DataIn_3;
	end
	
endmodule