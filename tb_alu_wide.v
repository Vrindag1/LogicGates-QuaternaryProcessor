module tb_alu_wide;
  reg  [7:0] A, B;
  reg  [2:0] opcode;
  wire [7:0] Result;
  wire       Zero, Carry;
  quat_alu_wide ALU(
    .A(A),.B(B),
    .opcode(opcode),
    .Result(Result),
    .Zero(Zero),
    .Carry(Carry));
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_alu_wide);

    $display("=== WIDE QUATERNARY ALU TEST ===");
    $display("A (q3q2q1q0) + B (q3q2q1q0) = Result | Carry");
    $display("---------------------------------------------");

    opcode = 3'b000;
    // Test 1: 0,0,0,1 + 0,0,0,1 = 0,0,0,2
    A = 8'b00_00_00_01;
    B = 8'b00_00_00_01; #20;
    $display("ADD: %b + %b = %b | carry=%0d",
             A, B, Result, Carry);

    // Test 2: 0,0,3,3 + 0,0,0,1 = 0,1,0,0 (carry chain)
    A = 8'b00_00_11_11;
    B = 8'b00_00_00_01; #20;
    $display("ADD: %b + %b = %b | carry=%0d",
             A, B, Result, Carry);

    // Test 3: 3,3,3,3 + 0,0,0,1 = 0,0,0,0 carry=1
    A = 8'b11_11_11_11;
    B = 8'b00_00_00_01; #20;
    $display("ADD: %b + %b = %b | carry=%0d",
             A, B, Result, Carry);

    // Test 4: MAX digit by digit
    opcode = 3'b001;
    A = 8'b11_01_10_00;  // 3,1,2,0
    B = 8'b01_11_00_10;  // 1,3,0,2
    #20;
    $display("MAX: %b | %b = %b (expect 11_11_10_10)",
             A, B, Result);

    // Test 5: SUC all digits
    opcode = 3'b011;
    A = 8'b11_10_01_00;  // 3,2,1,0
    #20;
    $display("SUC: %b = %b (expect 00_11_10_01)",
             A, Result);

    $display("=== DONE ===");
    $finish;
  end
endmodule
