module rom4_im(
	input Address, 
	output signed [13-1:0] Value
);

	reg signed[13-1:0] data;
	always @(Address) begin
		case (Address)
			0 : data = 13'd0;
			1 : data = -13'd2048;
		endcase
	end
	
	assign Value = data;
	
endmodule