module reorder_ctrl(
	input Clk, Reset, 
	output reg [5-1:0] counter, 
	output reg select
);

	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			counter <= 5'd29;
			select <= 1'b0;
		end
		else begin
			counter <= counter + 1'b1;
			if (counter == 5'd31)
				select <= ~select;
		end
	end

endmodule
