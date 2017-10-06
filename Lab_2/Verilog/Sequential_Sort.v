module Sequential_Sort(
  input Clk, Reset, 
  input [11:0] DataIn, 
  output reg [11:0] DataOut
);
  
  wire [11:0] dff_d;
  always @(posedge Clk or posedge Reset) begin
    if (Reset)
      DataOut <= 12'hfff;
    else
      DataOut <= dff_d;
  end
  
  wire select;
  Mux U0(DataOut, DataIn, select, dff_d);
  Comparator U1(DataIn[11:4], DataOut[11:4], select);
  
endmodule
