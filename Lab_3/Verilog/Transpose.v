module Transpose(
	input Clk, Reset, 
	input signed [15-1:0] X, 
	output reg signed [19-1:0] Y
);
	// Initialize H
	reg signed [16-1:0] H [32:0];
	initial begin
		H[0] = 16'b11_11111111111111;
		H[1] = 16'b11_11110011110010;
		H[2] = 16'b11_11100110110010;
		H[3] = 16'b11_11011011001010;
		H[4] = 16'b11_11010011010001;
		H[5] = 16'b11_11010001011101;
		H[6] = 16'b11_11010111101011;
		H[7] = 16'b11_11100111000111;
		H[8] = 16'b00_00000000000000;
		H[9] = 16'b00_00100001011001;
		H[10] = 16'b00_01001001010000;
		H[11] = 16'b00_01110100100010;
		H[12] = 16'b00_10011111100100;
		H[13] = 16'b00_11000110011001;
		H[14] = 16'b00_11100101010001;
		H[15] = 16'b00_11111001001001;
		H[16] = 16'b01_00000000000000;
		H[17] = 16'b00_11111001001001;
		H[18] = 16'b00_11100101010001;
		H[19] = 16'b00_11000110011001;
		H[20] = 16'b00_10011111100100;
		H[21] = 16'b00_01110100100010;
		H[22] = 16'b00_01001001010000;
		H[23] = 16'b00_00100001011001;
		H[24] = 16'b00_00000000000000;
		H[25] = 16'b11_11100111000111;
		H[26] = 16'b11_11010111101011;
		H[27] = 16'b11_11010001011101;
		H[28] = 16'b11_11010011010001;
		H[29] = 16'b11_11011011001010;
		H[30] = 16'b11_11100110110010;
		H[31] = 16'b11_11110011110010;
		H[32] = 16'b11_11111111111111;
	end
	
	// Z[0]
	reg signed [31-1:0] Mul_tmp_I;
	reg signed [16-1:0] Mul_Out_I, FF;
	always @(*) begin
		Mul_tmp_I = X * H[32];
		Mul_Out_I = Mul_tmp_I[28:13];
	end
	always @(posedge Clk or posedge Reset) begin
		if (Reset)
			FF <= 0;
		else
			FF <= Mul_Out_I;
	end
	wire signed [19-1:0] F_Out [31:0];
	assign F_Out[31] = FF;
	
	// Z[1]~Z[30]
	genvar i;
	generate
		for (i=0; i<=30; i=i+1) begin : A0
			Unit_transpose FF (
				Clk, Reset, X, H[i+1], F_Out[i+1], 
				F_Out[i]
			);
		end 
	endgenerate
	
	// Z[31]
	reg signed [31-1:0] Mul_tmp_O;
	reg signed [16-1:0] Mul_Out_O;
	always @(*) begin
		Mul_tmp_O = X * H[0];
		Mul_Out_O = Mul_tmp_O[28:13];
	end
	reg signed [20-1:0] Add_tmp_O;
	reg signed [19-1:0] Add_Out_O;
	always @(*) begin
		Add_tmp_O = {{3{Mul_Out_O[15]}}, Mul_Out_O} + F_Out[0];
		Add_Out_O = Add_tmp_O[18:0];
	end
	
	// Output Flip Flop
	always @(posedge Clk or posedge Reset) begin
		if (Reset)
			Y <= 0;
		else
			Y <= Add_Out_O;
	end
	
endmodule
