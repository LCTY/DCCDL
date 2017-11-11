module Unit_Stage_B(
	input signed [15-1:0] X, Y, 
	output reg signed [15-1:0] X_out, Y_out
);
	parameter i = 1;
	
	reg u;
	// u = -sgn(Y), u=1 for negative, u=0 for positive
	always @(*) begin
		if (Y[14] == 0) // Y >= 0
			u = 1'b1;
		else
			u = 1'b0;
	end
	
	reg signed [15-1:0] X_s, Y_s;
	always @(*) begin
		// Arithmetic right shift
		X_s = X >>> i;
		Y_s = Y >>> i;
		
		// u is positive
		if (u == 0) begin
			X_out = X - Y_s;
			Y_out = X_s + Y;
		end
		// u is negative
		else begin
			X_out = X + Y_s;
			Y_out = Y - X_s;
		end
	end

endmodule
