module tb_alu;
  reg  [1:0] A, B;
  reg  [2:0] opcode;
  wire [1:0] Result;
  wire       Zero, Carry;

  quat_alu_complete ALU(
    .A(A), .B(B),
    .opcode(opcode),
    .Result(Result),
    .Zero(Zero),
    .Carry(Carry)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_alu);

    $display("=== QUATERNARY ALU TEST ===");
    $display("Op      | A | B | Result | Zero | Carry");
    $display("--------+---+---+--------+------+------");

    // ADD (000)
    opcode=3'b000; A=2'd1; B=2'd2; #20;
    $display("ADD     | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);
    opcode=3'b000; A=2'd3; B=2'd3; #20;
    $display("ADD     | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);

    // MAX (001)
    opcode=3'b001; A=2'd1; B=2'd3; #20;
    $display("MAX     | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);
    opcode=3'b001; A=2'd2; B=2'd2; #20;
    $display("MAX     | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);

    // MIN (010)
    opcode=3'b010; A=2'd1; B=2'd3; #20;
    $display("MIN     | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);
    opcode=3'b010; A=2'd0; B=2'd2; #20;
    $display("MIN     | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);

    // SUC (011)
    opcode=3'b011; A=2'd0; B=2'd0; #20;
    $display("SUC     | %0d | - |   %0d    |  %0d   |  %0d", A,Result,Zero,Carry);
    opcode=3'b011; A=2'd3; B=2'd0; #20;
    $display("SUC     | %0d | - |   %0d    |  %0d   |  %0d", A,Result,Zero,Carry);

    // TSUM (100)
    opcode=3'b100; A=2'd2; B=2'd3; #20;
    $display("TSUM    | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);
    opcode=3'b100; A=2'd1; B=2'd1; #20;
    $display("TSUM    | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);

    // COMPARE (110)
    opcode=3'b110; A=2'd3; B=2'd1; #20;
    $display("CMP GT  | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);
    opcode=3'b110; A=2'd1; B=2'd3; #20;
    $display("CMP GT  | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);

    // EQUAL (111)
    opcode=3'b111; A=2'd2; B=2'd2; #20;
    $display("EQUAL   | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);
    opcode=3'b111; A=2'd1; B=2'd3; #20;
    $display("EQUAL   | %0d | %0d |   %0d    |  %0d   |  %0d", A,B,Result,Zero,Carry);

    $display("=== DONE ===");
    $finish;
  end
endmodule
