module quat_add4(
  input  [7:0] A,
  input  [7:0] B,
  output [7:0] Sum,
  output [1:0] Cout
);
  // A = {q3,q2,q1,q0} each 2 bits
  // Add digit by digit with carry chain

  wire [1:0] a0,a1,a2,a3;
  wire [1:0] b0,b1,b2,b3;
  wire [1:0] s0,s1,s2,s3;
  wire [1:0] c1,c2,c3;

  // Unpack digits
  assign a0 = A[1:0]; assign b0 = B[1:0];
  assign a1 = A[3:2]; assign b1 = B[3:2];
  assign a2 = A[5:4]; assign b2 = B[5:4];
  assign a3 = A[7:6]; assign b3 = B[7:6];

  // 4 full adders in ripple carry chain
  quat_full_adder FA0(.A(a0),.B(b0),.Cin(2'b00),.Sum(s0),.Cout(c1));
  quat_full_adder FA1(.A(a1),.B(b1),.Cin(c1),   .Sum(s1),.Cout(c2));
  quat_full_adder FA2(.A(a2),.B(b2),.Cin(c2),   .Sum(s2),.Cout(c3));
  quat_full_adder FA3(.A(a3),.B(b3),.Cin(c3),   .Sum(s3),.Cout(Cout));

  // Pack result
  assign Sum = {s3,s2,s1,s0};
endmodule
