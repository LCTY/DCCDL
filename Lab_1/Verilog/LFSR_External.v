module LFSR_External(
	input Clk, Reset, 
	output Out
);
	reg [4:0] s;
	assign Out = s[4];
	
	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			s <= 5'b10101;
		end
		else begin
			s <= {s[3], s[2], s[1], s[0], s[1]^s[4]};
		end
	end

endmodule
