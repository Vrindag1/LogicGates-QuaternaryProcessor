module quat_half_adder(
  input  [1:0] A,
  input  [1:0] B,
  output [1:0] Sum,
  output [1:0] Carry
);
  wire [3:0] total;
  assign total = {2'b00, A} + {2'b00, B};
  assign Sum   = total[1:0];
  assign Carry = total[3:2];
endmodule