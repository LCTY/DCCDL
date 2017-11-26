module rom16_re(
	input [2:0] Address, 
	output signed [13-1:0] Value
);

	reg signed[13-1:0] data;
	always @(Address) begin
		case (Address)
			0 : data = 13'd2048;
			1 : data = 13'd1892;
			2 : data = 13'd1448;
			3 : data = 13'd783;
			4 : data = 13'd0;
			5 : data = -13'd784;
			6 : data = -13'd1449;
			7 : data = -13'd1893;
		endcase
	end
	
	assign Value = data;
	
endmodule