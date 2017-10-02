module dff(
	input Clk, Reset, D,  
	output reg Q
);
	always @(posedge Clk or posedge Reset) begin
		if (Reset)
			Q <= 1'b1;
		else
			Q <= D;
	end
	
endmodule
