module cmul #(parameter WIDTH = 13)(
	input signed [WIDTH-1:0] X_re, X_im, 
	input signed [13-1:0] Y_re, Y_im, 
	output reg signed [WIDTH-1:0] Z_re, Z_im
);	
	
	reg signed [WIDTH+13-1:0] tmp1, tmp2, tmp3, tmp4;
	reg signed [WIDTH-1:0] tmp1_t, tmp2_t, tmp3_t, tmp4_t;
	
	always @(*) begin
		tmp1 = X_re * Y_re;
		tmp1_t = {tmp1[WIDTH+13-1], tmp1[23+WIDTH-13-1:23-1], tmp1[22-1:12-1]};
		tmp2 = X_im * Y_im;
		tmp2_t = {tmp2[WIDTH+13-1], tmp2[23+WIDTH-13-1:23-1], tmp2[22-1:12-1]};
		tmp3 = X_im * Y_re;
		tmp3_t = {tmp3[WIDTH+13-1], tmp3[23+WIDTH-13-1:23-1], tmp3[22-1:12-1]};
		tmp4 = X_re * Y_im;
		tmp4_t = {tmp4[WIDTH+13-1], tmp4[23+WIDTH-13-1:23-1], tmp4[22-1:12-1]};
		
		Z_re = tmp1_t - tmp2_t;
		Z_im = tmp3_t + tmp4_t;
	end

endmodule
