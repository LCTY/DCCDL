`timescale 1ns / 1ps

module stage_final_testbench;

	// Inputs
	reg Clk;
	reg Reset;
	reg [15:0] Low_in_re;
	reg [15:0] Low_in_im;

	// Outputs
	wire [16:0] Low_out_re;
	wire [16:0] Low_out_im;
	wire mode;

	// Instantiate the Unit Under Test (UUT)
	stage_final uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.mode(mode), 
		.Low_in_re(Low_in_re), 
		.Low_in_im(Low_in_im), 
		.Low_out_re(Low_out_re), 
		.Low_out_im(Low_out_im)
	);
	
	always #20 Clk = ~Clk;
	/*
	integer mcd1;
	always @ (posedge Clk) begin
		#20; $fwrite(mcd1,"%d\t%d\n", $signed(Low_out_re), $signed(Low_out_im));
	end*/

	initial begin
		//mcd1 = $fopen("../stage5_low.txt");
		Clk = 1;
		Reset = 1;
		Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		
		#140; Reset = 0;
		#20; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		#40; Low_in_re = -16'd6;	Low_in_im = -16'd2055;	
		#40; Low_in_re = -16'd2055;	Low_in_im = -16'd8;	
		#40; Low_in_re = -16'd2046;	Low_in_im = 16'd3;	
		#40; Low_in_re = 16'd2;	Low_in_im = -16'd2047;	
		#40; Low_in_re = -16'd2045;	Low_in_im = 16'd2050;	
		#40; Low_in_re = 16'd1;	Low_in_im = -16'd3;	
		#40; Low_in_re = -16'd2047;	Low_in_im = 16'd2;	
		#40; Low_in_re = -16'd3;	Low_in_im = -16'd2049;	
		#40; Low_in_re = 16'd0;	Low_in_im = -16'd4;	
		#40; Low_in_re = 16'd2048;	Low_in_im = 16'd2042;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd2052;	
		#40; Low_in_re = 16'd2048;	Low_in_im = 16'd2;	
		#40; Low_in_re = 16'd0;	Low_in_im = -16'd2048;	
		#40; Low_in_re = 16'd2048;	Low_in_im = -16'd3;	
		#40; Low_in_re = -16'd2048;	Low_in_im = 16'd0;	
		#40; Low_in_re = -16'd3;	Low_in_im = -16'd2048;	
		#40; Low_in_re = -16'd2050;	Low_in_im = -16'd2054;	
		#40; Low_in_re = 16'd0;	Low_in_im = -16'd8;	
		#40; Low_in_re = -16'd2050;	Low_in_im = -16'd2046;	
		#40; Low_in_re = -16'd2;	Low_in_im = -16'd2;	
		#40; Low_in_re = 16'd2050;	Low_in_im = 16'd2052;	
		#40; Low_in_re = 16'd2;	Low_in_im = -16'd2;	
		#40; Low_in_re = 16'd2050;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd0;	Low_in_im = -16'd2048;	
		#40; Low_in_re = -16'd2048;	Low_in_im = -16'd2049;	
		#40; Low_in_re = 16'd0;	Low_in_im = -16'd1;	
		#40; Low_in_re = 16'd0;	Low_in_im = -16'd2047;	
		#40; Low_in_re = -16'd2051;	Low_in_im = 16'd2;	
		#40; Low_in_re = -16'd2049;	Low_in_im = 16'd0;	
		#40; Low_in_re = 16'd3;	Low_in_im = 16'd2050;	
		#40; Low_in_re = 16'd2049;	Low_in_im = 16'd2048;	
		#40; Low_in_re = 16'd2;	Low_in_im = -16'd3;	
		#40; Low_in_re = 16'd0;	Low_in_im = 16'd0;	
		
		//#40 $fclose(mcd1); $finish;

	end
      
endmodule

