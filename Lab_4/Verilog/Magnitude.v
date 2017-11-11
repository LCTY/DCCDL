module Magnitude(
	input Clk, Reset, 
	input signed [12-1:0] X, Y, 
	output reg signed [13-1:0] Magnitude
);

	wire signed [15-1:0] X0, Y0;
	Abs A0(X, Y, X0, Y0);
	
	wire signed [15-1:0] X_out [10:0];
	wire signed [15-1:0] Y_out [10:0];
	
	Unit_Stage_B#(0) U0(
		X0, Y0, 
		X_out[0], Y_out[0]
	);
	
	genvar i;
	generate
		for (i=1; i<11; i=i+1) begin : Stage
			Unit_Stage_B#(i) Unit(
				X_out[i-1], Y_out[i-1], 
				X_out[i], Y_out[i]
			);
		end
	endgenerate
	
	
	// Shift_and_Add
	wire [13-1:0] X_trun = X_out[10][15-1:2];
	reg [23-1:0] Xs_0, Xs_1, Xs_3, Xs_4, Xs_6, Xs_7, Xs_10;
	reg [24-1:0] Add_out;
	
	always @(*) begin
		Xs_0 = {{10{1'b0}}, X_trun};
		Xs_1 = {{9{1'b0}}, X_trun, {1{1'b0}}};
		Xs_3 = {{7{1'b0}}, X_trun, {3{1'b0}}};
		Xs_4 = {{6{1'b0}}, X_trun, {4{1'b0}}};
		Xs_6 = {{4{1'b0}}, X_trun, {6{1'b0}}};
		Xs_7 = {{3{1'b0}}, X_trun, {7{1'b0}}};
		Xs_10 = {X_trun, {10{1'b0}}};
		Add_out = {1'b0, Xs_0 + Xs_1 + Xs_3 + Xs_4 + Xs_6 + Xs_7 + Xs_10};
	end
	
	always @(posedge Clk or posedge Reset) begin
		if (Reset)
			Magnitude <= 0;
		else
			Magnitude <= Add_out[24-1:11];
	end

endmodule
