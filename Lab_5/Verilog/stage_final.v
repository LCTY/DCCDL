module stage_final #(parameter WIDTH = 17, MODE = 0)(
	input Clk, Reset, 
	output reg mode, 
	input signed [WIDTH-2:0] Low_in_re, Low_in_im, 
	output signed [WIDTH-1:0] Low_out_re, Low_out_im
);
	reg signed [WIDTH-1:0] z_re, z_im;
	reg signed [WIDTH-1:0] up_in_re, up_in_im;
	wire signed [WIDTH-1:0] up_out_re, up_out_im;
	
	//reg mode;
	
	butterfly#(WIDTH) U0(up_in_re, up_in_im, {Low_in_re[WIDTH-2], Low_in_re}, {Low_in_im[WIDTH-2], Low_in_im}, mode, up_out_re, up_out_im, Low_out_re, Low_out_im);
	
	always @(*) begin
		up_in_re = z_re;
		up_in_im = z_im;
	end
	
	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			z_re <= {WIDTH{1'b0}};
			z_im <= {WIDTH{1'b0}};
			mode <= MODE;
		end
		else begin
			z_re <= up_out_re;
			z_im <= up_out_im;
			mode <= ~mode;
		end
	end

endmodule
