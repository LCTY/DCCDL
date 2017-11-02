module Unit_transpose(
	input Clk, Reset, 
	input signed [15-1:0] X, 
	input signed [16-1:0] H, 
	input signed [19-1:0] Add_In, 
	output reg signed [19-1:0] F_Out
);

	always @(posedge Clk or posedge Reset) begin
		if (Reset)
			F_Out <= 0;
		else
			F_Out <= Add_Out;
	end
	
	reg signed [31-1:0] Mul_tmp;
	reg signed [16-1:0] Mul_Out;
	always @(*) begin
		Mul_tmp = X * H;
		Mul_Out = Mul_tmp[28:13];
	end
	
	reg signed [20-1:0] Add_tmp;
	reg signed [19-1:0] Add_Out;
	
	always @(*) begin
		Add_tmp = {{3{Mul_Out[15]}}, Mul_Out} + Add_In;
		Add_Out = Add_tmp[18:0];
	end
	
endmodule
