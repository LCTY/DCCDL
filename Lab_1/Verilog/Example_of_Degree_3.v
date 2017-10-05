module A_Way(
	input Clk, Reset, 
	output Output
);
	
	wire d0, d1, d2, q0, q1, q2;
	
	dff s0(Clk, Reset, d0, q0);
	dff s1(Clk, Reset, d1, q1);
	dff s2(Clk, Reset, d2, q2);
	
	xor (d0, q0, q1);
	assign d1 = q2;
	assign d2 = q0;
	
	assign Output = q0;

endmodule


module B_Way(
	input Clk, Reset, 
	output Out
);
	reg [2:0] s;
	assign Out = s[0];
	
	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			s <= 3'd7;
		end
		else begin
			s <= {s[0],s[2], s[1]^s[0]};
		end
	end

endmodule

