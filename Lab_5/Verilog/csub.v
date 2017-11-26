module csub #(parameter WIDTH = 13)(
	input signed [WIDTH-1:0] X_re, X_im, Y_re, Y_im, 
	output reg signed [WIDTH-1:0] Z_re, Z_im
);

	always @(*) begin
		Z_re = X_re - Y_re;
		Z_im = X_im - Y_im;
	end

endmodule
