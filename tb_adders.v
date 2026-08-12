module tb_adders;
  reg  [1:0] A, B, Cin;
  wire [1:0] ha_sum, ha_carry;
  wire [1:0] fa_sum, fa_cout;
  quat_half_adder HA(
    .A(A), .B(B),
    .Sum(ha_sum), .Carry(ha_carry)
  );
  quat_full_adder FA(
    .A(A), .B(B), .Cin(Cin),
    .Sum(fa_sum), .Cout(fa_cout)
  );
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_adders);
    $display("=== HALF ADDER (from Sooriamala Table) ===");
    $display("A  B | Sum | Carry");
    $display("-----+-----+------");
    A=0; B=0; #10;
    $display("%0d  %0d |  %0d  |  %0d", A,B,ha_sum,ha_carry);
    A=0; B=1; #10;
    $display("%0d  %0d |  %0d  |  %0d", A,B,ha_sum,ha_carry);
    A=1; B=2; #10;
    $display("%0d  %0d |  %0d  |  %0d", A,B,ha_sum,ha_carry);
    A=2; B=2; #10;
    $display("%0d  %0d |  %0d  |  %0d", A,B,ha_sum,ha_carry);
    A=3; B=3; #10;
    $display("%0d  %0d |  %0d  |  %0d", A,B,ha_sum,ha_carry);
    $display("");

    $display("=== FULL ADDER ===");
    $display("A  B  Cin | Sum | Cout");
    $display("---------+-----+-----");
    A=1; B=2; Cin=0; #10;
    $display("%0d  %0d   %0d  |  %0d  |  %0d", A,B,Cin,fa_sum,fa_cout);
    A=3; B=3; Cin=0; #10;
    $display("%0d  %0d   %0d  |  %0d  |  %0d", A,B,Cin,fa_sum,fa_cout);
    A=3; B=3; Cin=1; #10;
    $display("%0d  %0d   %0d  |  %0d  |  %0d", A,B,Cin,fa_sum,fa_cout);
    A=2; B=3; Cin=2; #10;
    $display("%0d  %0d   %0d  |  %0d  |  %0d", A,B,Cin,fa_sum,fa_cout);
    $display("=== DONE ===");
    $finish;
  end
endmodule
