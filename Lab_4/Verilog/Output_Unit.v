module Output_Unit(
	input Clk, Reset, X_sign, Y_sign, 
	input signed [16-1:0] Theta_10, 
	output reg signed [17-1:0] Theta
);

	always @(posedge Clk or posedge Reset) begin
		if (Reset)
			Theta <= 17'd0;
			
		// First quadrant: theta
		else if ((X_sign == 0) && (Y_sign == 0))
			Theta <= Theta_10;
			
		// Second quadrant: pi - theta
		else if ((X_sign == 1) && (Y_sign == 0))
			Theta <= 17'sd51471 - Theta_10;
		
		// Third quadrant: theta - pi
		else if ((X_sign == 1) && (Y_sign == 1))
			Theta <= Theta_10 - 17'sd51471;
		
		// Fourth quadrant: -theta
		else
			Theta <= 17'sd0 - Theta_10;
	end

endmodule
