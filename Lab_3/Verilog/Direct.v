module Direct(
	input Clk, Reset, 
	input signed [14-1:0] X, 
	output reg signed [18-1:0] Y
);
	// Initialize H
	reg signed [13:0] H_0 = 14'b11_111111111111;
	reg signed [14-1:0] H [31:0];
	initial begin
		H[0] = 14'b11_111100111100;
		H[1] = 14'b11_111001101100;
		H[2] = 14'b11_110110110010;
		H[3] = 14'b11_110100110100;
		H[4] = 14'b11_110100010111;
		H[5] = 14'b11_110101111010;
		H[6] = 14'b11_111001110001;
		H[7] = 14'b00_000000000000;
		H[8] = 14'b00_001000010110;
		H[9] = 14'b00_010010010100;
		H[10] = 14'b00_011101001000;
		H[11] = 14'b00_100111111001;
		H[12] = 14'b00_110001100110;
		H[13] = 14'b00_111001010100;
		H[14] = 14'b00_111110010010;
		H[15] = 14'b01_000000000000;
		H[16] = 14'b00_111110010010;
		H[17] = 14'b00_111001010100;
		H[18] = 14'b00_110001100110;
		H[19] = 14'b00_100111111001;
		H[20] = 14'b00_011101001000;
		H[21] = 14'b00_010010010100;
		H[22] = 14'b00_001000010110;
		H[23] = 14'b00_000000000000;
		H[24] = 14'b11_111001110001;
		H[25] = 14'b11_110101111010;
		H[26] = 14'b11_110100010111;
		H[27] = 14'b11_110100110100;
		H[28] = 14'b11_110110110010;
		H[29] = 14'b11_111001101100;
		H[30] = 14'b11_111100111100;
		H[31] = 14'b11_111111111111;
	end
	
	// Z[0]
	reg signed [28-1:0] Mul_tmp;
	reg signed [15-1:0] Mul_Out;
	always @(*) begin
		Mul_tmp = X * H_0;
		Mul_Out = Mul_tmp[25:11];
	end
	wire signed [14-1:0] F_Out [31:0];
	wire signed [18-1:0] Add_Out [31:0];
	Unit_direct A0(
		Clk, Reset, H[0], X, {{5{Mul_Out[13]}}, Mul_Out[12:0]}, 
		F_Out[0], Add_Out[0]
	);
	
	// Z[1]~Z[31]
	genvar i;
	generate
		for (i=1; i<=31; i=i+1) begin : A1
			Unit_direct FF (
				Clk, Reset, H[i], F_Out[i-1], Add_Out[i-1], 
				F_Out[i], Add_Out[i]
			);
		end 
	endgenerate
	
	// Output Flip Flop
	always @(posedge Clk or posedge Reset) begin
		if (Reset)
			Y <= 0;
		else
			Y <= Add_Out[31];
	end
	
endmodule
