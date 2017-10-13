module Comparator_B(
	input [11:0] A, B, 
	output reg [11:0] Y
);
	wire [8:0] temp;
	assign temp = {1'b0, A[11:4]} - {1'b0, B[11:4]};
	
	always @(*) begin
		if (temp[8] == 1'b1)
			Y = A;
		else
			Y = B;
	end

endmodule