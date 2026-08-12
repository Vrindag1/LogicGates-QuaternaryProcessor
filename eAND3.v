
module eAND3(
  input  [1:0] A,
  input  [1:0] B,
  output [1:0] Y
);
  assign Y = ((A == 2'd3) && (B == 2'd3)) ? 2'd3 : 2'd0;
endmodule
