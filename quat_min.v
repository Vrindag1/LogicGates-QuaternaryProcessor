
module quat_min(
  input  [1:0] A,
  input  [1:0] B,
  output [1:0] Y
);
wire sel;
bit2LessThanEqualTo U1 (
    .A(A),
    .B(B),
    .Y(sel)
);
assign Y = (sel) ? A : B;
endmodule
