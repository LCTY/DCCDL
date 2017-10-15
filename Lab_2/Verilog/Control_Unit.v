module Control_Unit(
	input Clk, Reset, 
	input [2:0] GroupNumber, 
	output reg [1:0] Index_0, Index_1, Index_2, Index_3, Index_4, Index_5
);

	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			Index_0 <= 5'd0;
			Index_1 <= 5'd0;
			Index_2 <= 5'd0;
			Index_3 <= 5'd0;
			Index_4 <= 5'd0;
			Index_5 <= 5'd0;
		end
		else begin
			case (GroupNumber)
				3'd0 : begin
					Index_0 <= Index_0 + 1'b1;
					Index_1 <= Index_1;
					Index_2 <= Index_2;
					Index_3 <= Index_3;
					Index_4 <= Index_4;
					Index_5 <= Index_5;
				end
				3'd1 : begin
					Index_0 <= Index_0;
					Index_1 <= Index_1 + 1'b1;
					Index_2 <= Index_2;
					Index_3 <= Index_3;
					Index_4 <= Index_4;
					Index_5 <= Index_5;
				end
				3'd2 : begin
					Index_0 <= Index_0;
					Index_1 <= Index_1;
					Index_2 <= Index_2 + 1'b1;
					Index_3 <= Index_3;
					Index_4 <= Index_4;
					Index_5 <= Index_5;
				end
				3'd3 : begin
					Index_0 <= Index_0;
					Index_1 <= Index_1;
					Index_2 <= Index_2;
					Index_3 <= Index_3 + 1'b1;
					Index_4 <= Index_4;
					Index_5 <= Index_5;
				end
				3'd4 : begin
					Index_0 <= Index_0;
					Index_1 <= Index_1;
					Index_2 <= Index_2;
					Index_3 <= Index_3;
					Index_4 <= Index_4 + 1'b1;
					Index_5 <= Index_5;
				end
				3'd5 : begin
					Index_0 <= Index_0;
					Index_1 <= Index_1;
					Index_2 <= Index_2;
					Index_3 <= Index_3;
					Index_4 <= Index_4;
					Index_5 <= Index_5 + 1'b1;
				end
				default : begin
					Index_0 <= Index_0;
					Index_1 <= Index_1;
					Index_2 <= Index_2;
					Index_3 <= Index_3;
					Index_4 <= Index_4;
					Index_5 <= Index_5;
				end
			endcase
		end
	
	end

endmodule
