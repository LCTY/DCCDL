module Comparator(
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

endmodule
