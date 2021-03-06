module Arctangent(
	input Clk, Reset, 
	input signed [12-1:0] X, Y, 
	output signed [17-1:0] Theta
);
	reg [2-1:0] count;
	always @(posedge Clk or posedge Reset) begin
		if (Reset)
			count <= 2'd0;
		else
			count <= count + 1'b1;
	end
	wire clk = count[1];

	reg signed [16-1:0] Theta_element [10:0];
	initial begin
		Theta_element[0] = 16'd12867;
		Theta_element[1] = 16'd7596;
		Theta_element[2] = 16'd4013;
		Theta_element[3] = 16'd2037;
		Theta_element[4] = 16'd1022;
		Theta_element[5] = 16'd511;
		Theta_element[6] = 16'd255;
		Theta_element[7] = 16'd127;
		Theta_element[8] = 16'd63;
		Theta_element[9] = 16'd31;
		Theta_element[10] = 16'd15;
	end

	wire signed [15-1:0] X0, Y0;
	Abs A0(X, Y, X0, Y0);
	
	wire signed [15-1:0] X_out [10:0];
	wire signed [15-1:0] Y_out [10:0];
	wire signed [16-1:0] Theta_out [10:0];
	
	Unit_Stage_A#(0) U0(
		X0, Y0, 16'd0, Theta_element[0], 
		X_out[0], Y_out[0], Theta_out[0]
	);
	
	genvar i;
	generate
		for (i=1; i<11; i=i+1) begin : Stage
			Unit_Stage_A#(i) Unit(
				X_out[i-1], Y_out[i-1], Theta_out[i-1], Theta_element[i], 
				X_out[i], Y_out[i], Theta_out[i]
			);
		end
	endgenerate
	
	Output_Unit Output_Unit(clk, Reset, X[11], Y[11], Theta_out[10], Theta);

endmodule
