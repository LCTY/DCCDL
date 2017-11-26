module rom32_re(
	input [3:0] Address, 
	output signed [13-1:0] Value
);

	reg signed[13-1:0] data;
	always @(Address) begin
		case (Address)
			0 : data = 13'd2048;
			1 : data = 13'd2008;
			2 : data = 13'd1892;
			3 : data = 13'd1702;
			4 : data = 13'd1448;
			5 : data = 13'd1137;
			6 : data = 13'd783;
			7 : data = 13'd399;
			8 : data = 13'd0;
			9 : data = -13'd400;
			10 : data = -13'd784;
			11 : data = -13'd1138;
			12 : data = -13'd1449;
			13 : data = -13'd1703;
			14 : data = -13'd1893;
			15 : data = -13'd2009;
		endcase
	end
	
	assign Value = data;
	
endmodule