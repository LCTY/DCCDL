module fft(
	input Clk, Reset, 
	input signed [12-1:0] X_re, X_im, 
	output signed [17-1:0] Y0_re, Y0_im, Y1_re, Y1_im, 
	output signed [17-1:0] mul_re, mul_im, 
	output mode1, mode2, mode3, mode4, mode5, 
	output [5-1:0] counter, 
	output select
);
	//assign mul_re = STAGE[1].scope1.mul_out_re;
	//assign mul_im = STAGE[1].scope1.mul_out_im;
	assign mul_re = STAGE[4].scope2.low_out_re;
	assign mul_im = STAGE[4].scope2.low_out_im;
	
	reorder_ctrl C0(Clk, Reset, counter, select);
	
	reg buff0_wr, buff1_wr;	
	always @(*) begin
		if (select == 1'b0) begin
			buff0_wr = 1'b1;
			buff1_wr = 1'b0;
		end
		else begin
			buff0_wr = 1'b0;
			buff1_wr = 1'b1;
		end
	end
	reorder_buff#(17, 32) B0(
		Clk, Reset, buff0_wr, 
		STAGE[4].scope2.low_out_re, STAGE[4].scope2.low_out_im, 
		Y0_re, Y0_im
	);
	reorder_buff#(17, 32) B1(
		Clk, Reset, buff1_wr, 
		STAGE[4].scope2.low_out_re, STAGE[4].scope2.low_out_im, 
		Y1_re, Y1_im
	);
	
	genvar i;
	generate
		for (i=0; i<5; i=i+1) begin : STAGE
			// wire scope
			if (i < 4) begin : scope1				
				wire [13+i-1:0] mul_out_re, mul_out_im;
				wire [13-1:0] rom_re, rom_im;
				wire [4-i-1:0] rom_idx;
			end
			else begin : scope2				
				wire [13+4-1:0] low_out_re, low_out_im;
			end
			
			// Stage 1
			if (i == 0) begin
				stage#(13+i, 2**(4-i), 0, 0) s0(
					Clk, Reset, mode1, 
					X_re, X_im, 
					STAGE[i].scope1.mul_out_re, STAGE[i].scope1.mul_out_im, 
					STAGE[i].scope1.rom_re, STAGE[i].scope1.rom_im, 
					STAGE[i].scope1.rom_idx
				);
			end
			// Stage 2~4
			else if (i < 4) begin
				wire [12+i-1:0] low_in_re, low_in_im;
				assign low_in_re = STAGE[i-1].scope1.mul_out_re;
				assign low_in_im = STAGE[i-1].scope1.mul_out_im;
				
				if (i == 1)
					stage#(13+i, 2**(4-i), 7, 1) s0(
						Clk, Reset, mode2, 
						low_in_re, low_in_im, 
						STAGE[i].scope1.mul_out_re, STAGE[i].scope1.mul_out_im, 
						STAGE[i].scope1.rom_re, STAGE[i].scope1.rom_im, 
						STAGE[i].scope1.rom_idx
					);
				else if (i == 2)
					stage#(13+i, 2**(4-i), 2, 1) s0(
						Clk, Reset, mode3, 
						low_in_re, low_in_im, 
						STAGE[i].scope1.mul_out_re, STAGE[i].scope1.mul_out_im, 
						STAGE[i].scope1.rom_re, STAGE[i].scope1.rom_im, 
						STAGE[i].scope1.rom_idx
					);
				else
					stage#(13+i, 2**(4-i), 1, 0) s0(
						Clk, Reset, mode4, 
						low_in_re, low_in_im, 
						STAGE[i].scope1.mul_out_re, STAGE[i].scope1.mul_out_im, 
						STAGE[i].scope1.rom_re, STAGE[i].scope1.rom_im, 
						STAGE[i].scope1.rom_idx
					);
			end
			// Stage 5
			else begin
				wire [12+i-1:0] low_in_re, low_in_im;
				assign low_in_re = STAGE[i-1].scope1.mul_out_re;
				assign low_in_im = STAGE[i-1].scope1.mul_out_im;
				
				stage_final#(13+i, 0) s1(
					Clk, Reset, mode5, 
					low_in_re, low_in_im, 
					STAGE[i].scope2.low_out_re, STAGE[i].scope2.low_out_im
				);
			end
			
			// ROM
			case (i)
				0 : begin
					rom32_re U0(STAGE[i].scope1.rom_idx, STAGE[i].scope1.rom_re);
					rom32_im U1(STAGE[i].scope1.rom_idx, STAGE[i].scope1.rom_im);
				end
				1 : begin
					rom16_re U0(STAGE[i].scope1.rom_idx, STAGE[i].scope1.rom_re);
					rom16_im U1(STAGE[i].scope1.rom_idx, STAGE[i].scope1.rom_im);
				end
				2 : begin
					rom8_re U0(STAGE[i].scope1.rom_idx, STAGE[i].scope1.rom_re);
					rom8_im U1(STAGE[i].scope1.rom_idx, STAGE[i].scope1.rom_im);
				end
				3 : begin
					rom4_re U0(STAGE[i].scope1.rom_idx, STAGE[i].scope1.rom_re);
					rom4_im U1(STAGE[i].scope1.rom_idx, STAGE[i].scope1.rom_im);
				end
			endcase
			
			
		end
	endgenerate

endmodule
