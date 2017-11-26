module stage #(parameter WIDTH = 13, N = 16, IDX = 0, MODE = 0)(
	input Clk, Reset, 
	output reg mode, 
	input signed [WIDTH-2:0] Low_in_re, Low_in_im, 
	output reg signed [WIDTH-1:0] Mul_out_re, Mul_out_im, 
	input signed [13-1:0] Rom_re, Rom_im, 
	output reg [$clog2(N)-1:0] Rom_idx
);
	parameter idx_len = $clog2(N);
	reg signed [WIDTH-1:0] z_re[N-1:0], z_im[N-1:0];
	reg signed [WIDTH-1:0] up_in_re, up_in_im;
	wire signed [WIDTH-1:0] up_out_re, up_out_im, low_out_re, low_out_im;
	reg signed [13-1:0] multiplier_re, multiplier_im;
	wire signed [WIDTH-1:0] mul_out_re, mul_out_im;
	
	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			Mul_out_re <= {WIDTH{1'b0}};
			Mul_out_im <= {WIDTH{1'b0}};
		end
		else begin
			Mul_out_re <= mul_out_re;
			Mul_out_im <= mul_out_im;
		end
	end
	
	//reg mode;
	
	butterfly#(WIDTH) U0(up_in_re, up_in_im, {Low_in_re[WIDTH-2], Low_in_re}, {Low_in_im[WIDTH-2], Low_in_im}, mode, up_out_re, up_out_im, low_out_re, low_out_im);
	cmul#(WIDTH) U1(low_out_re, low_out_im, multiplier_re, multiplier_im, mul_out_re, mul_out_im);
	
	always @(*) begin
		up_in_re = z_re[N-1];
		up_in_im = z_im[N-1];
		
		if (mode == 1'b0) begin
			multiplier_re = Rom_re;
			multiplier_im = Rom_im;
		end
		else begin
			multiplier_re = 13'd2048;
			multiplier_im = 13'd0;
		end
	end
	
	integer i; 
	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			for (i=0; i<N; i=i+1) begin
				z_re[i] <= {WIDTH{1'b0}};
				z_im[i] <= {WIDTH{1'b0}};
			end
			mode <= MODE;
			Rom_idx <= IDX;
		end
		else begin
			z_re[0] <= up_out_re;
			z_im[0] <= up_out_im;
			for (i=0; i<N-1; i=i+1) begin
				z_re[i+1] <= z_re[i];
				z_im[i+1] <= z_im[i];
			end
			if (Rom_idx == (N-1))
				mode <= ~mode;
			else
				mode <= mode;
			Rom_idx <= Rom_idx + 1'b1;
		end
	end

endmodule
