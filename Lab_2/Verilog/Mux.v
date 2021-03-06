module Mux(
	input [11:0] X_1, X_2, 
	input Select, 
	output reg [11:0] Y
);
	
	always @(*) begin
		if (Select == 1'b0)
			Y = X_1;
		else
			Y = X_2;
	end

endmodule
