module Abs(
	input signed [12-1:0] X, Y, 
	output signed [15-1:0] X_out, Y_out
);
	reg signed [12-1:0] X_tmp, Y_tmp;

	always @(*) begin
		if (X<0)
			X_tmp = 12'sd0 - X;
		else
			X_tmp = X;
			
		if (Y<0)
			Y_tmp = 12'sd0 - Y;
		else
			Y_tmp = Y;
	end
	
	assign X_out = {1'b0, X_tmp[12-1-1:0], {3{1'b0}}};
	assign Y_out = {1'b0, Y_tmp[12-1-1:0], {3{1'b0}}};

endmodule
