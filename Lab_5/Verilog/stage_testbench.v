`timescale 1ns / 1ps

module stage_testbench;
	parameter WIDTH = 14, N = 8;

	// Inputs
	reg Clk;
	reg Reset;
	reg [WIDTH-2:0] Low_in_re;
	reg [WIDTH-2:0] Low_in_im;
	reg [13-1:0] Rom_re;
	reg [13-1:0] Rom_im;

	// Outputs
	wire mode;
	wire [WIDTH-1:0] Mul_out_re;
	wire [WIDTH-1:0] Mul_out_im;
	wire [$clog2(N)-1:0] Rom_idx;
	wire [WIDTH-1:0] low_out_re, low_out_im;

	// Instantiate the Unit Under Test (UUT)
	stage#(WIDTH, N) uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.mode(mode), 
		.Low_in_re(Low_in_re), 
		.Low_in_im(Low_in_im), 
		.Mul_out_re(Mul_out_re), 
		.Mul_out_im(Mul_out_im), 
		.Rom_re(Rom_re), 
		.Rom_im(Rom_im), 
		.Rom_idx(Rom_idx), 
		.low_out_re(low_out_re), 
		.low_out_im(low_out_im)
	);

	always #20 Clk = ~Clk;

	initial begin
		// Initialize Inputs
		Clk = 1;
		Reset = 1;
		//Low_in_re = -12'd640;	Low_in_im = -12'd256;	Rom_re = 13'd2048;	Rom_im = 13'd0;
		Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd2048;	Rom_im = 13'd0;	

		// Wait 10 ns for global reset to finish
		#140; Reset = 0;
		
		#20; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd1893;	Rom_im = -13'd784;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd2048;	Rom_im = 13'd0;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd1893;	Rom_im = -13'd784;	
		#40; Low_in_re = -13'd1024;	Low_in_im = 13'd0;	Rom_re = 13'd2048;	Rom_im = 13'd0;	
		#40; Low_in_re = 13'd417;	Low_in_im = 13'd1224;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = 13'd180;	Low_in_im = -13'd76;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = -13'd234;	Low_in_im = 13'd54;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = -13'd257;	Low_in_im = -13'd257;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = -13'd280;	Low_in_im = -13'd337;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd1054;	Low_in_im = -13'd76;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		#40; Low_in_re = -13'd930;	Low_in_im = 13'd278;	Rom_re = -13'd1893;	Rom_im = -13'd784;	
		#40; Low_in_re = -13'd512;	Low_in_im = 13'd0;	Rom_re = 13'd2048;	Rom_im = 13'd0;	
		#40; Low_in_re = -13'd56;	Low_in_im = -13'd864;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = -13'd182;	Low_in_im = -13'd438;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = -13'd430;	Low_in_im = -13'd419;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd767;	Low_in_im = -13'd769;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = -13'd85;	Low_in_im = -13'd26;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = -13'd32;	Low_in_im = -13'd439;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		#40; Low_in_re = -13'd457;	Low_in_im = 13'd82;	Rom_re = -13'd1893;	Rom_im = -13'd784;	
		#40; Low_in_re = -13'd256;	Low_in_im = -13'd512;	Rom_re = 13'd2048;	Rom_im = 13'd0;	
		#40; Low_in_re = 13'd42;	Low_in_im = 13'd42;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = 13'd106;	Low_in_im = -13'd363;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = 13'd42;	Low_in_im = -13'd320;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = -13'd257;	Low_in_im = -13'd1025;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = 13'd154;	Low_in_im = 13'd152;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd256;	Low_in_im = -13'd725;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		#40; Low_in_re = -13'd516;	Low_in_im = -13'd155;	Rom_re = -13'd1893;	Rom_im = -13'd784;	
		#40; Low_in_re = 13'd256;	Low_in_im = 13'd0;	Rom_re = 13'd2048;	Rom_im = 13'd0;	
		#40; Low_in_re = 13'd321;	Low_in_im = 13'd318;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = -13'd619;	Low_in_im = 13'd361;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = 13'd319;	Low_in_im = -13'd43;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = -13'd1793;	Low_in_im = -13'd513;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = -13'd516;	Low_in_im = -13'd517;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd257;	Low_in_im = 13'd723;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		#40; Low_in_re = 13'd154;	Low_in_im = 13'd515;	Rom_re = -13'd1893;	Rom_im = -13'd784;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd2048;	Rom_im = 13'd0;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd1893;	Rom_im = -13'd784;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd2048;	Rom_im = 13'd0;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = 13'd0;	Low_in_im = 13'd0;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		
		
		/*
		#20; Low_in_re = 12'd225;	Low_in_im = 12'd637;	Rom_re = 13'd2008;	Rom_im = -13'd400;	
		#40; Low_in_re = 12'd208;	Low_in_im = -12'd185;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = -12'd11;	Low_in_im = -12'd94;	Rom_re = 13'd1702;	Rom_im = -13'd1138;	
		#40; Low_in_re = 12'd143;	Low_in_im = -12'd581;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = -12'd161;	Low_in_im = -12'd62;	Rom_re = 13'd1137;	Rom_im = -13'd1703;	
		#40; Low_in_re = 12'd910;	Low_in_im = -12'd58;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = -12'd440;	Low_in_im = -12'd129;	Rom_re = 13'd399;	Rom_im = -13'd2009;	
		#40; Low_in_re = -12'd256;	Low_in_im = 12'd128;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = -12'd216;	Low_in_im = -12'd306;	Rom_re = -13'd400;	Rom_im = -13'd2009;	
		#40; Low_in_re = -12'd140;	Low_in_im = -12'd574;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = -12'd286;	Low_in_im = -12'd65;	Rom_re = -13'd1138;	Rom_im = -13'd1703;	
		#40; Low_in_re = 12'd1198;	Low_in_im = -12'd837;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		#40; Low_in_re = 12'd315;	Low_in_im = 12'd58;	Rom_re = -13'd1703;	Rom_im = -13'd1138;	
		#40; Low_in_re = -12'd273;	Low_in_im = -12'd505;	Rom_re = -13'd1893;	Rom_im = -13'd784;	
		#40; Low_in_re = -12'd354;	Low_in_im = -12'd197;	Rom_re = -13'd2009;	Rom_im = -13'd400;	
		#40; Low_in_re = -12'd384;	Low_in_im = 12'd256;	Rom_re = 13'd2048;	Rom_im = 13'd0;	
		#40; Low_in_re = 12'd192;	Low_in_im = 12'd587;	Rom_re = 13'd2008;	Rom_im = -13'd400;	
		#40; Low_in_re = -12'd28;	Low_in_im = 12'd109;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = -12'd223;	Low_in_im = 12'd148;	Rom_re = 13'd1702;	Rom_im = -13'd1138;	
		#40; Low_in_re = -12'd400;	Low_in_im = 12'd324;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = -12'd119;	Low_in_im = -12'd275;	Rom_re = 13'd1137;	Rom_im = -13'd1703;	
		#40; Low_in_re = 12'd144;	Low_in_im = -12'd18;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = -12'd490;	Low_in_im = 12'd407;	Rom_re = 13'd399;	Rom_im = -13'd2009;	
		#40; Low_in_re = -12'd256;	Low_in_im = -12'd128;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = 12'd160;	Low_in_im = -12'd558;	Rom_re = -13'd400;	Rom_im = -13'd2009;	
		#40; Low_in_re = -12'd42;	Low_in_im = 12'd136;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = -12'd144;	Low_in_im = -12'd354;	Rom_re = -13'd1138;	Rom_im = -13'd1703;	
		#40; Low_in_re = -12'd431;	Low_in_im = 12'd68;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		#40; Low_in_re = -12'd400;	Low_in_im = -12'd84;	Rom_re = -13'd1703;	Rom_im = -13'd1138;	
		#40; Low_in_re = 12'd241;	Low_in_im = 12'd66;	Rom_re = -13'd1893;	Rom_im = -13'd784;	
		#40; Low_in_re = -12'd103;	Low_in_im = 12'd279;	Rom_re = -13'd2009;	Rom_im = -13'd400;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = 13'd2048;	Rom_im = 13'd0;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = 13'd2008;	Rom_im = -13'd400;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = 13'd1892;	Rom_im = -13'd784;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = 13'd1702;	Rom_im = -13'd1138;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = 13'd1448;	Rom_im = -13'd1449;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = 13'd1137;	Rom_im = -13'd1703;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = 13'd783;	Rom_im = -13'd1893;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = 13'd399;	Rom_im = -13'd2009;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = 13'd0;	Rom_im = -13'd2048;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = -13'd400;	Rom_im = -13'd2009;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = -13'd784;	Rom_im = -13'd1893;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = -13'd1138;	Rom_im = -13'd1703;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = -13'd1449;	Rom_im = -13'd1449;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = -13'd1703;	Rom_im = -13'd1138;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = -13'd1893;	Rom_im = -13'd784;	
		#40; Low_in_re = 12'd0;	Low_in_im = 12'd0;	Rom_re = -13'd2009;	Rom_im = -13'd400;	
		*/
	end
      
endmodule
