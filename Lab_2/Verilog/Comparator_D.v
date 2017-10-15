module Comparator_D(
	input [15:0] A, B, 
	output reg [15:0] Y
);
	wire [8:0] temp;
	assign temp = {1'b0, A[15:8]} - {1'b0, B[15:8]};
	
	always @(*) begin
		if (temp[8] == 1'b1)
			Y = B;
		else
			Y = A;
	end

endmodule
