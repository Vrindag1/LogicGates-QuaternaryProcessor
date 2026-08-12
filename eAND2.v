module eAND2(
  input  [1:0] A,
  input  [1:0] B,
  output [1:0] Y
);
  assign Y = ((A == 2'd2) && (B == 2'd2)) ? 2'd2 : 2'd0;
endmodule
