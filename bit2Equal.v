module bit2Equal(
    input  [1:0] A,
    input  [1:0] B,
    output Y
);

wire w1, w2;

xnor x1(w1, A[1], B[1]);
xnor x2(w2, A[0], B[0]);
and  a1(Y, w1, w2);

endmodule