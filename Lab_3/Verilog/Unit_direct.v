module Unit_direct(
	input Clk, Reset, 
	input signed [14-1:0] H, 
	input signed [14-1:0] F_In, 
	input signed [18-1:0] Add_In, 
	output reg signed [14-1:0] F_Out, 
	output reg signed [18-1:0] Add_Out
);

	always @(posedge Clk or posedge Reset) begin
		if (Reset)
			F_Out <= 0;
		else
			F_Out <= F_In;
	end
	
	reg signed [28-1:0] Mul_tmp;
	reg signed [15-1:0] Mul_Out;
	always @(*) begin
		Mul_tmp = F_Out * H;
		Mul_Out = Mul_tmp[25:11];
	end
	
	reg signed [19-1:0] Add_tmp;
	always @(*) begin
		Add_tmp = {{3{Mul_Out[14]}}, Mul_Out} + Add_In;
		Add_Out = {Add_tmp[17:13], Add_tmp[12:0]};
	end
	
endmodule
