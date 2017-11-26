module rom16_im(
	input [2:0] Address, 
	output signed [13-1:0] Value
);

	reg signed[13-1:0] data;
	always @(Address) begin
		case (Address)
			0 : data = 13'd0;
			1 : data = -13'd784;
			2 : data = -13'd1449;
			3 : data = -13'd1893;
			4 : data = -13'd2048;
			5 : data = -13'd1893;
			6 : data = -13'd1449;
			7 : data = -13'd784;
		endcase
	end
	
	assign Value = data;
	
endmodule