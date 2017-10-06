module Comparator(
	input [7:0] A, B, 
	output reg Y
);
	wire [8:0] temp;
	assign temp = {1'b0, A} - {1'b0, B};
	
	always @(*) begin
		if (temp[8] == 1'b1)
			Y = 1'b1;
		else
			Y = 1'b0;
	end

endmodule
