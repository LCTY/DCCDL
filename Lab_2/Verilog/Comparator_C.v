module Comparator_C(
	input [11:0] A, B, 
	output reg [11:0] Max, Min
);
	wire [8:0] temp;
	assign temp = {1'b0, A[11:4]} - {1'b0, B[11:4]};
	
	always @(*) begin
		if (temp[8] == 1'b1) begin
			Max = B;
			Min = A;
		end
		else begin
			Max = A;
			Min = B;
		end
	end

endmodule