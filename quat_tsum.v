module quat_tsum(
  input  [1:0] A,
  input  [1:0] B,
  output [1:0] Y
);
  wire [2:0] total;
  assign total = {1'b0, A} + {1'b0, B};
  assign Y = (total > 3) ? 2'd3 : total[1:0];
endmodule