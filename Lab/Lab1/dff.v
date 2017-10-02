module dff(
	input Clk, Reset, LdEnable, Data, Load, 
	output reg Q
);
	always @(posedge Clk or negedge Reset) begin
		if (!Reset)
			Q <= 0;
		else if (LdEnable)
			Q <= Load;
		else
			Q <= Data;
	end
	
endmodule
