module reorder_ctrl(
	input Clk, Reset, 
	output reg [5-1:0] counter, 
	output reg select, 
	output reg [1:0] buffer_write_enable
);

	always @(*) begin
		if (select == 1'b0) begin
			buffer_write_enable[0] = 1'b1;
			buffer_write_enable[1] = 1'b0;
		end
		else begin
			buffer_write_enable[0] = 1'b0;
			buffer_write_enable[1] = 1'b1;
		end
	end

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
