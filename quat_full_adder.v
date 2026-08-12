module quat_full_adder(
  input  [1:0] A,
  input  [1:0] B,
  input  [1:0] Cin,
  output [1:0] Sum,
  output [1:0] Cout
);
  wire [3:0] total;
  assign total = {2'b00, A} + {2'b00, B} + {2'b00, Cin};
  assign Sum   = total[1:0];
  assign Cout  = total[3:2];
endmodule
