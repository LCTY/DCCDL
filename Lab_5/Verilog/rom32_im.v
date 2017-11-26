module rom32_im(
	input [3:0] Address, 
	output signed [13-1:0] Value
);

	reg signed[13-1:0] data;
	always @(Address) begin
		case (Address)
			0 : data = 13'd0;
			1 : data = -13'd400;
			2 : data = -13'd784;
			3 : data = -13'd1138;
			4 : data = -13'd1449;
			5 : data = -13'd1703;
			6 : data = -13'd1893;
			7 : data = -13'd2009;
			8 : data = -13'd2048;
			9 : data = -13'd2009;
			10 : data = -13'd1893;
			11 : data = -13'd1703;
			12 : data = -13'd1449;
			13 : data = -13'd1138;
			14 : data = -13'd784;
			15 : data = -13'd400;
		endcase
	end
	
	assign Value = data;
	
endmodule