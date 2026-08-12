module quat_suc(
  input  [1:0] A,
  output [1:0] Y
);
  assign Y = A + 2'b01; // 2-bit overflow = automatic mod 4
endmodule