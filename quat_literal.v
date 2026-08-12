module quat_literal(
    input [1:0] A,
    input [1:0] K,
    output [1:0] Y
);

assign Y = (A == K) ? A : 2'b00;

endmodule