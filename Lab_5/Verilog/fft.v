module fft(
	input Clk, Reset, 
	input signed [12-1:0] X_re, X_im, 
	output reg signed [17-1:0] Y_re, Y_im, 
	output signed [14-1:0] mul_re, mul_im, 
	output mode1, mode2, mode3, mode4, mode5
);
	assign mul_re = STAGE[1].scope1.mul_out_re;
	assign mul_im = STAGE[1].scope1.mul_out_im;

	//reg mode[5-1:0];
	//assign m = mode[0];
	//reg [4-1:0] counter;
	always @(posedge Clk or posedge Reset) begin
		if (Reset) begin
			//counter <= 4'd15;
			Y_re <= 17'd0;
			Y_im <= 17'd0;
		end
		else begin
			//counter <= counter - 1'b1;
			Y_re <= STAGE[4].scope2.low_out_re;
			Y_im <= STAGE[4].scope2.low_out_im;
		end
	end
	
	genvar i;
	generate
		for (i=0; i<5; i=i+1) begin : STAGE
			// wire scope
			if (i < 4) begin : scope1
				/*
				always @(posedge counter[4-1-i] or posedge Reset) begin
					if (Reset) begin
						if ((i%(2**(4-i+1)) > 0) && (i%(2**(4-i+1)) <= (2**(4-i))))
							mode[i] <= 1'b1;
						else
							mode[i] <= 1'b0;
					end
					else
						mode[i] <= ~mode[i];
				end
				*/
				
				wire [13+i-1:0] mul_out_re, mul_out_im;
				wire [13-1:0] rom_re, rom_im;
				wire [4-i-1:0] rom_idx;
			end
			else begin : scope2
				/*
				always @(posedge Clk or posedge Reset) begin
					if (Reset) mode[4] <= 1'b1;
					else mode[4] <= ~mode[4];
				end
				*/
				
				wire [13+4-1:0] low_out_re, low_out_im;
			end
			
			// Stage1~5
			if (i == 0) begin
				stage#(13+i, 2**(4-i), 0, 0) s0(
					Clk, Reset, mode1, 
					X_re, X_im, 
					STAGE[i].scope1.mul_out_re, STAGE[i].scope1.mul_out_im, 
					STAGE[i].scope1.rom_re, STAGE[i].scope1.rom_im, 
					STAGE[i].scope1.rom_idx
				);
			end
			else if (i == 4) begin
				wire [12+i-1:0] low_in_re, low_in_im;
				assign low_in_re = STAGE[i-1].scope1.mul_out_re;
				assign low_in_im = STAGE[i-1].scope1.mul_out_im;
				
				stage_final#(13+i, 0) s1(
					Clk, Reset, mode5, 
					low_in_re, low_in_im, 
					STAGE[i].scope2.low_out_re, STAGE[i].scope2.low_out_im
				);
				/*
				stage#(13+i, 2**(4-i)) s0(
					Clk, Reset, mode[i], 
					low_in_re, low_in_im, 
					STAGE[i].scope2.mul_out_re, STAGE[i].scope2.mul_out_im, 
					STAGE[i].scope2.rom_re, STAGE[i].scope2.rom_im, 
					STAGE[i].scope2.rom_idx
				);
				*/
			end
			else begin
				wire [12+i-1:0] low_in_re, low_in_im;
				assign low_in_re = STAGE[i-1].scope1.mul_out_re;
				assign low_in_im = STAGE[i-1].scope1.mul_out_im;
				/*
				assign low_in_re = {STAGE[i].scope1.mul_out_re[i-1][13+i-2], STAGE[i].scope1.mul_out_re[i-1]};
				assign low_in_im = {STAGE[i].scope1.mul_out_im[i-1][13+i-2], STAGE[i].scope1.mul_out_im[i-1]};
				*/
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
				/*
				if ((i%(2**(4-i+1)) > 0) && (i%(2**(4-i+1)) <= (2**(4-i))))
					stage#(13+i, 2**(4-i), (2**(4-i))+1-(i%(2**(4-i))), 1) s0(
						Clk, Reset, 
						low_in_re, low_in_im, 
						STAGE[i].scope1.mul_out_re, STAGE[i].scope1.mul_out_im, 
						STAGE[i].scope1.rom_re, STAGE[i].scope1.rom_im, 
						STAGE[i].scope1.rom_idx
					);
				else
					stage#(13+i, 2**(4-i), (2**(4-i))+1-(i%(2**(4-i))), 0) s0(
						Clk, Reset, 
						low_in_re, low_in_im, 
						STAGE[i].scope1.mul_out_re, STAGE[i].scope1.mul_out_im, 
						STAGE[i].scope1.rom_re, STAGE[i].scope1.rom_im, 
						STAGE[i].scope1.rom_idx
					);
				*/
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
	
	/*
	wire [13-1:0] mul_out_re_1, mul_out_im_1;
	wire [13-1:0] rom_re_1, rom_im_1;
	wire [4-1:0] rom_idx_1;
	rom32_re U0(rom_idx_1, rom_re_1);
	rom32_im U1(rom_idx_1, rom_im_1);
	stage#(13, 16) s1(
		Clk, Reset, mode[0], 
		X_re, X_im, 
		mul_out_re_1, mul_out_im_1, 
		rom_re_1, rom_im_1, 
		rom_idx_1
	);
	*/
	

endmodule
