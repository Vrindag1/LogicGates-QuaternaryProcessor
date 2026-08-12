module bit2LessThanEqualTo(
    input [1:0] A,
    input [1:0] B,
    output wire Y
);
wire w1,w2,w5,w6,w7,w8,w9,w10,w11,w12,w13;
assign w1= ~(A[1]);
assign w2= ~(A[0]);


and a1 (w5,w1,B[1]);
and a2 (w6,w2,B[0]);
and a3 (w7,w6,w8);
and a4(w10,w12,w9);
or o1(w8,B[1],w1);
or o2(w11,w7,w5);
or o3(w13,w10,w11);
xnor x1(w9,B[1],A[1]);
xnor x2(w12,B[0],A[0]);
assign Y=w13;
endmodule