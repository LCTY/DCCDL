module Scrambler(
	input Clk, Reset, D1, 
	output reg Out
);
	reg [4:0] s;
	wire linear_feedback;
	
	always @(posedge Clk or posedge Reset) begin
		if (Reset) Out <= 0;
		else Out <= linear_feedback;
	end
	
	assign linear_feedback = s[4]^s[3]^s[1]^s[0]^D1;
	
	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			s <= 5'b10101;
		end
		else begin
			s <= {s[3], s[2], s[1], s[0], linear_feedback};
		end
	end

endmodule
