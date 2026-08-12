
module tb_half_adder;
  reg  [1:0] A, B;
  wire [1:0] Sum, Carry;

  quat_half_adder UHA(.A(A),.B(B),.Sum(Sum),.Carry(Carry));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_half_adder);

    $display("A  B | Sum | Carry");
    $display("-----+-----+------");

    A=0; B=0; #20;
    $display("%0d  %0d |  %0d  |   %0d", A,B,Sum,Carry);
    A=0; B=1; #20;
    $display("%0d  %0d |  %0d  |   %0d", A,B,Sum,Carry);
    A=0; B=2; #20;
    $display("%0d  %0d |  %0d  |   %0d", A,B,Sum,Carry);
    A=0; B=3; #20;
    $display("%0d  %0d |  %0d  |   %0d", A,B,Sum,Carry);
    A=1; B=1; #20;
    $display("%0d  %0d |  %0d  |   %0d", A,B,Sum,Carry);
    A=1; B=2; #20;
    $display("%0d  %0d |  %0d  |   %0d", A,B,Sum,Carry);
    A=1; B=3; #20;
    $display("%0d  %0d |  %0d  |   %0d", A,B,Sum,Carry);
    A=2; B=2; #20;
    $display("%0d  %0d |  %0d  |   %0d", A,B,Sum,Carry);
    A=2; B=3; #20;
    $display("%0d  %0d |  %0d  |   %0d", A,B,Sum,Carry);
    A=3; B=3; #20;
    $display("%0d  %0d |  %0d  |   %0d", A,B,Sum,Carry);

    $finish;
  end
endmodule