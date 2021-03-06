module rom8_re(
	input [1:0] Address, 
	output signed [13-1:0] Value
);

	reg signed[13-1:0] data;
	always @(Address) begin
		case (Address)
			0 : data = 13'd2048;
			1 : data = 13'd1448;
			2 : data = 13'd0;
			3 : data = -13'd1449;
		endcase
	end
	
	assign Value = data;
	
endmodule