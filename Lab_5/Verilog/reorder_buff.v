module reorder_buff #(parameter WIDTH = 17, N = 32)(
	input Clk, Reset, Write_en, 
	input signed [WIDTH-1:0] In_re, In_im, 
	output reg signed [WIDTH-1:0] Out_re, Out_im
);
	reg [WIDTH-1:0] z_re[N-1:0], z_im[N-1:0], array_re[N-1:0], array_im[N-1:0];
	reg [$clog2(N)-1:0] count;
	
	always @(*) begin
		if (Write_en) begin
			Out_re = 0;
			Out_im = 0;
		end
		else begin
			Out_re = array_re[count];
			Out_im = array_im[count];
		end
	end
	
	integer i;
	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			count <= 0;
			for (i=0; i<N; i=i+1) begin
				z_re[i] <= 0;
				z_im[i] <= 0;
			end
		end
		else if (Write_en) begin
			count <= 0;
			z_re[0] <= In_re;
			z_im[0] <= In_im;
			for (i=0; i<N-1; i=i+1) begin
				z_re[i+1] <= z_re[i];
				z_im[i+1] <= z_im[i];
			end
		end
		else begin
			count <= count + 1'b1;
			for (i=0; i<N; i=i+1) begin
				z_re[i] <= z_re[i];
				z_im[i] <= z_im[i];
			end
		end
	end
	
	// Memory array
	always @(*) begin
		array_re[0] = z_re[31];
		array_re[1] = z_re[15];
		array_re[2] = z_re[23];
		array_re[3] = z_re[7];
		array_re[4] = z_re[27];
		array_re[5] = z_re[11];
		array_re[6] = z_re[19];
		array_re[7] = z_re[3];
		array_re[8] = z_re[29];
		array_re[9] = z_re[13];
		array_re[10] = z_re[21];
		array_re[11] = z_re[5];
		array_re[12] = z_re[25];
		array_re[13] = z_re[9];
		array_re[14] = z_re[17];
		array_re[15] = z_re[1];
		array_re[16] = z_re[30];
		array_re[17] = z_re[14];
		array_re[18] = z_re[22];
		array_re[19] = z_re[6];
		array_re[20] = z_re[26];
		array_re[21] = z_re[10];
		array_re[22] = z_re[18];
		array_re[23] = z_re[2];
		array_re[24] = z_re[28];
		array_re[25] = z_re[12];
		array_re[26] = z_re[20];
		array_re[27] = z_re[4];
		array_re[28] = z_re[24];
		array_re[29] = z_re[8];
		array_re[30] = z_re[16];
		array_re[31] = z_re[0];
		array_im[0] = z_im[31];
		array_im[1] = z_im[15];
		array_im[2] = z_im[23];
		array_im[3] = z_im[7];
		array_im[4] = z_im[27];
		array_im[5] = z_im[11];
		array_im[6] = z_im[19];
		array_im[7] = z_im[3];
		array_im[8] = z_im[29];
		array_im[9] = z_im[13];
		array_im[10] = z_im[21];
		array_im[11] = z_im[5];
		array_im[12] = z_im[25];
		array_im[13] = z_im[9];
		array_im[14] = z_im[17];
		array_im[15] = z_im[1];
		array_im[16] = z_im[30];
		array_im[17] = z_im[14];
		array_im[18] = z_im[22];
		array_im[19] = z_im[6];
		array_im[20] = z_im[26];
		array_im[21] = z_im[10];
		array_im[22] = z_im[18];
		array_im[23] = z_im[2];
		array_im[24] = z_im[28];
		array_im[25] = z_im[12];
		array_im[26] = z_im[20];
		array_im[27] = z_im[4];
		array_im[28] = z_im[24];
		array_im[29] = z_im[8];
		array_im[30] = z_im[16];
		array_im[31] = z_im[0];
	end

endmodule
