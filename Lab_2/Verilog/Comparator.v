module Comparator(
<<<<<<< HEAD
	input [7:0] A, B, 
	output reg Y
);
	wire [8:0] temp;
	assign temp = {1'b0, A} - {1'b0, B};
	
	always @(*) begin
		if (temp[8] == 1'b1)
			Y = 1'b1;
		else
			Y = 1'b0;
	end
=======
  input [7:0] A, B, 
  output reg Y
);
  wire [7:0] temp;
  assign temp = A - B;
  
  always @(*) begin
    if (temp[7] == 1'b1)
      Y = 1'b0;
    else
      Y = 1'b1;
  end
>>>>>>> a871106e420eeb6a05bcb6ff5df712c20aab2568

endmodule
