`timescale 1ns / 1ps

module fft_testbench;

	// Inputs
	reg Clk;
	reg Reset;
	reg signed [11:0] X_re;
	reg signed [11:0] X_im;

	// Outputs
	wire signed [16:0] Y0_re, Y0_im, Y1_re, Y1_im;
	//wire m;
	wire signed [17-1:0] mul_re, mul_im;
	wire mode1, mode2, mode3, mode4, mode5;
	wire [5-1:0] counter;
	wire select;

	// Instantiate the Unit Under Test (UUT)
	fft uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.X_re(X_re), 
		.X_im(X_im), 
		.Y0_re(Y0_re), 
		.Y0_im(Y0_im), 
		.Y1_re(Y1_re), 
		.Y1_im(Y1_im), 
		.mul_re(mul_re), 
		.mul_im(mul_im), 
		.mode1(mode1), 
		.mode2(mode2), 
		.mode3(mode3), 
		.mode4(mode4), 
		.mode5(mode5), 
		.counter(counter), 
		.select(select)
	);
	
	always #20 Clk = ~Clk;
	
	integer mcd1, mcd2;
	always @ (posedge Clk) begin
		$fwrite(mcd1,"%d\t%d\n", $signed(Y0_re), $signed(Y0_im));
		$fwrite(mcd2,"%d\t%d\n", $signed(Y1_re), $signed(Y1_im));
	end
	
	initial begin
		mcd1 = $fopen("../Y0.txt");
		mcd2 = $fopen("../Y1.txt");
		Clk = 1;
		Reset = 1;
		X_re = -12'd640;	X_im = -12'd256;

		#140; Reset = 0;
		#40; X_re = 12'd225;	X_im = 12'd637;
		#40; X_re = 12'd208;	X_im = -12'd185;
		#40; X_re = -12'd11;	X_im = -12'd94;
		#40; X_re = 12'd143;	X_im = -12'd581;
		#40; X_re = -12'd161;	X_im = -12'd62;
		#40; X_re = 12'd910;	X_im = -12'd58;
		#40; X_re = -12'd440;	X_im = -12'd129;
		#40; X_re = -12'd256;	X_im = 12'd128;
		#40; X_re = -12'd216;	X_im = -12'd306;
		#40; X_re = -12'd140;	X_im = -12'd574;
		#40; X_re = -12'd286;	X_im = -12'd65;
		#40; X_re = 12'd1198;	X_im = -12'd837;
		#40; X_re = 12'd315;	X_im = 12'd58;
		#40; X_re = -12'd273;	X_im = -12'd505;
		#40; X_re = -12'd354;	X_im = -12'd197;
		#40; X_re = -12'd384;	X_im = 12'd256;
		#40; X_re = 12'd192;	X_im = 12'd587;
		#40; X_re = -12'd28;	X_im = 12'd109;
		#40; X_re = -12'd223;	X_im = 12'd148;
		#40; X_re = -12'd400;	X_im = 12'd324;
		#40; X_re = -12'd119;	X_im = -12'd275;
		#40; X_re = 12'd144;	X_im = -12'd18;
		#40; X_re = -12'd490;	X_im = 12'd407;
		#40; X_re = -12'd256;	X_im = -12'd128;
		#40; X_re = 12'd160;	X_im = -12'd558;
		#40; X_re = -12'd42;	X_im = 12'd136;
		#40; X_re = -12'd144;	X_im = -12'd354;
		#40; X_re = -12'd431;	X_im = 12'd68;
		#40; X_re = -12'd400;	X_im = -12'd84;
		#40; X_re = 12'd241;	X_im = 12'd66;
		#40; X_re = -12'd103;	X_im = 12'd279;
		
		#40; X_re = -12'd640;	X_im = -12'd256;
		#40; X_re = 12'd225;	X_im = 12'd637;
		#40; X_re = 12'd208;	X_im = -12'd185;
		#40; X_re = -12'd11;	X_im = -12'd94;
		#40; X_re = 12'd143;	X_im = -12'd581;
		#40; X_re = -12'd161;	X_im = -12'd62;
		#40; X_re = 12'd910;	X_im = -12'd58;
		#40; X_re = -12'd440;	X_im = -12'd129;
		#40; X_re = -12'd256;	X_im = 12'd128;
		#40; X_re = -12'd216;	X_im = -12'd306;
		#40; X_re = -12'd140;	X_im = -12'd574;
		#40; X_re = -12'd286;	X_im = -12'd65;
		#40; X_re = 12'd1198;	X_im = -12'd837;
		#40; X_re = 12'd315;	X_im = 12'd58;
		#40; X_re = -12'd273;	X_im = -12'd505;
		#40; X_re = -12'd354;	X_im = -12'd197;
		#40; X_re = -12'd384;	X_im = 12'd256;
		#40; X_re = 12'd192;	X_im = 12'd587;
		#40; X_re = -12'd28;	X_im = 12'd109;
		#40; X_re = -12'd223;	X_im = 12'd148;
		#40; X_re = -12'd400;	X_im = 12'd324;
		#40; X_re = -12'd119;	X_im = -12'd275;
		#40; X_re = 12'd144;	X_im = -12'd18;
		#40; X_re = -12'd490;	X_im = 12'd407;
		#40; X_re = -12'd256;	X_im = -12'd128;
		#40; X_re = 12'd160;	X_im = -12'd558;
		#40; X_re = -12'd42;	X_im = 12'd136;
		#40; X_re = -12'd144;	X_im = -12'd354;
		#40; X_re = -12'd431;	X_im = 12'd68;
		#40; X_re = -12'd400;	X_im = -12'd84;
		#40; X_re = 12'd241;	X_im = 12'd66;
		#40; X_re = -12'd103;	X_im = 12'd279;
		
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
		#40; X_re = 12'd0;	X_im = 12'd0;
      		
		#1480 $fclose(mcd1); $fclose(mcd2); $finish;

	end
      
endmodule

