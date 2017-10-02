module LFSR_Internal(
	input Clk, Reset, 
	output Out
);
	reg [4:0] s;
	assign Out = s[0];
	
	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			s <= 5'b10101;
		end
		else begin
			s <= {s[0],s[4], s[3], s[2]^s[0], s[1]};
		end
	end

endmodule
