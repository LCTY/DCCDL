`timescale 1ns / 1ps

module fft_testbench;

	// Inputs
	reg Clk;
	reg Reset;
	reg signed [11:0] X_re;
	reg signed [11:0] X_im;

	// Outputs
	wire signed [17-1:0] Y_re, Y_im;
	/*
	wire signed [17-1:0] Y0_re, Y0_im, Y1_re, Y1_im;
	wire signed [13-1:0] mul_re, mul_im;
	wire mode1, mode2, mode3, mode4, mode5;
	*/
	//wire [5-1:0] counter;
	//wire select;
	
	/*
	.Y0_re(Y0_re), .Y0_im(Y0_im), .Y1_re(Y1_re), .Y1_im(Y1_im), 
		.mul_re(mul_re), .mul_im(mul_im), 
		.mode1(mode1), .mode2(mode2), .mode3(mode3), .mode4(mode4), .mode5(mode5)
	*/

	// Instantiate the Unit Under Test (UUT)
	fft uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.X_re(X_re), .X_im(X_im), 
		.Y_re(Y_re), .Y_im(Y_im)
	);
	parameter period = 20;
	
	always #(period/2) Clk = ~Clk;
	
	integer mcd1;
	always @ (posedge Clk) begin
		$fwrite(mcd1,"%d\t%d\n", $signed(Y_re), $signed(Y_im));
	end
	
	initial begin
		mcd1 = $fopen("../Y.txt");
		Clk = 1;
		Reset = 1;
		X_re = 12'd0;	X_im = 12'd0;
		
		/*
		//Behavioral
		#(6*period+2); Reset = 0; X_re = -12'd640;	X_im = -12'd256;
		#(period-2); X_re = 12'd225;	X_im = 12'd637;
		//Post-route
		#(6*period); Reset = 0;
		#5; X_re = -12'd640;	X_im = -12'd256;
		#(period); X_re = 12'd225;	X_im = 12'd637;
		*/
		
		//Post-route
		#(6*period); Reset = 0;
		#5; X_re = -12'd640;	X_im = -12'd256;
		#(period); X_re = 12'd225;	X_im = 12'd637;
		
		#period; X_re = 12'd208;	X_im = -12'd185;
		#period; X_re = -12'd11;	X_im = -12'd94;
		#period; X_re = 12'd143;	X_im = -12'd581;
		#period; X_re = -12'd161;	X_im = -12'd62;
		#period; X_re = 12'd910;	X_im = -12'd58;
		#period; X_re = -12'd440;	X_im = -12'd129;
		#period; X_re = -12'd256;	X_im = 12'd128;
		#period; X_re = -12'd216;	X_im = -12'd306;
		#period; X_re = -12'd140;	X_im = -12'd574;
		#period; X_re = -12'd286;	X_im = -12'd65;
		#period; X_re = 12'd1198;	X_im = -12'd837;
		#period; X_re = 12'd315;	X_im = 12'd58;
		#period; X_re = -12'd273;	X_im = -12'd505;
		#period; X_re = -12'd354;	X_im = -12'd197;
		#period; X_re = -12'd384;	X_im = 12'd256;
		#period; X_re = 12'd192;	X_im = 12'd587;
		#period; X_re = -12'd28;	X_im = 12'd109;
		#period; X_re = -12'd223;	X_im = 12'd148;
		#period; X_re = -12'd400;	X_im = 12'd324;
		#period; X_re = -12'd119;	X_im = -12'd275;
		#period; X_re = 12'd144;	X_im = -12'd18;
		#period; X_re = -12'd490;	X_im = 12'd407;
		#period; X_re = -12'd256;	X_im = -12'd128;
		#period; X_re = 12'd160;	X_im = -12'd558;
		#period; X_re = -12'd42;	X_im = 12'd136;
		#period; X_re = -12'd144;	X_im = -12'd354;
		#period; X_re = -12'd431;	X_im = 12'd68;
		#period; X_re = -12'd400;	X_im = -12'd84;
		#period; X_re = 12'd241;	X_im = 12'd66;
		#period; X_re = -12'd103;	X_im = 12'd279;
		#period; X_re = 12'd0;	X_im = 12'd0;
		/*
		#period; X_re = -12'd640;	X_im = -12'd256;
		#period; X_re = 12'd225;	X_im = 12'd637;
		#period; X_re = 12'd208;	X_im = -12'd185;
		#period; X_re = -12'd11;	X_im = -12'd94;
		#period; X_re = 12'd143;	X_im = -12'd581;
		#period; X_re = -12'd161;	X_im = -12'd62;
		#period; X_re = 12'd910;	X_im = -12'd58;
		#period; X_re = -12'd440;	X_im = -12'd129;
		#period; X_re = -12'd256;	X_im = 12'd128;
		#period; X_re = -12'd216;	X_im = -12'd306;
		#period; X_re = -12'd140;	X_im = -12'd574;
		#period; X_re = -12'd286;	X_im = -12'd65;
		#period; X_re = 12'd1198;	X_im = -12'd837;
		#period; X_re = 12'd315;	X_im = 12'd58;
		#period; X_re = -12'd273;	X_im = -12'd505;
		#period; X_re = -12'd354;	X_im = -12'd197;
		#period; X_re = -12'd384;	X_im = 12'd256;
		#period; X_re = 12'd192;	X_im = 12'd587;
		#period; X_re = -12'd28;	X_im = 12'd109;
		#period; X_re = -12'd223;	X_im = 12'd148;
		#period; X_re = -12'd400;	X_im = 12'd324;
		#period; X_re = -12'd119;	X_im = -12'd275;
		#period; X_re = 12'd144;	X_im = -12'd18;
		#period; X_re = -12'd490;	X_im = 12'd407;
		#period; X_re = -12'd256;	X_im = -12'd128;
		#period; X_re = 12'd160;	X_im = -12'd558;
		#period; X_re = -12'd42;	X_im = 12'd136;
		#period; X_re = -12'd144;	X_im = -12'd354;
		#period; X_re = -12'd431;	X_im = 12'd68;
		#period; X_re = -12'd400;	X_im = -12'd84;
		#period; X_re = 12'd241;	X_im = 12'd66;
		#period; X_re = -12'd103;	X_im = 12'd279;
		
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
		#period; X_re = 12'd0;	X_im = 12'd0;
      		
		#(42*period); $fclose(mcd1); $finish;
		*/
		#(84*period); $fclose(mcd1); $finish;
	end
      
endmodule
