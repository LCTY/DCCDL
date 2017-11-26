module butterfly #(parameter WIDTH = 13)(
	input signed [WIDTH-1:0] X_re, X_im, Y_re, Y_im, 
	input mode, 
	output reg signed [WIDTH-1:0] XO_re, XO_im, YO_re, YO_im
);

	wire signed [WIDTH-1:0] XO_re_tmp, XO_im_tmp, YO_re_tmp, YO_im_tmp;

	csub#(WIDTH) UP(X_re, X_im, Y_re, Y_im, XO_re_tmp, XO_im_tmp);
	cadd#(WIDTH) LOW(X_re, X_im, Y_re, Y_im, YO_re_tmp, YO_im_tmp);

	always @(*) begin
		if (mode == 1'b1) begin
			XO_re = XO_re_tmp;
			XO_im = XO_im_tmp;
			YO_re = YO_re_tmp;
			YO_im = YO_im_tmp;
		end
		else begin
			XO_re = Y_re;
			XO_im = Y_im;
			YO_re = X_re;
			YO_im = X_im;
		end
	end

endmodule
