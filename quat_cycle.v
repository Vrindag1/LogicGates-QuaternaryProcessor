module quat_cycle(
    input [1:0] A,
    output [1:0] Y
);
assign Y = A+2'b01;
endmodule