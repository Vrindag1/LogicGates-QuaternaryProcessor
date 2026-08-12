
module tb_fortugno_cells;
  reg  [1:0] A, B;
  wire [1:0] Y_min, Y_tsum, Y_cyc, Y_lr;
  wire [1:0] Y_lit1, Y_lit2, Y_lit3;

  quat_min          U_MIN(.A(A), .B(B), .Y(Y_min));
  quat_tsum         U_TS (.A(A), .B(B), .Y(Y_tsum));
  quat_cycle        U_CYC(.A(A), .Y(Y_cyc));
  quat_level_restore U_LR(.A(A), .Y(Y_lr));
  quat_literal      U_L1 (.A(A), .K(2'd1), .Y(Y_lit1));
  quat_literal      U_L2 (.A(A), .K(2'd2), .Y(Y_lit2));
  quat_literal      U_L3 (.A(A), .K(2'd3), .Y(Y_lit3));
  bit2LessThanEqualTo uut2 (.A(A),.B(B),.Y(Y));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_fortugno_cells);

    $display("A  B | MIN | TSUM | CYC | LIT1 | LIT2 | LIT3");
    $display("-----+-----+------+-----+------+------+-----");

    A=0; B=0; #20;
    $display("%0d  %0d |  %0d  |  %0d   |  %0d  |  %0d   |  %0d   |  %0d",
             A,B,Y_min,Y_tsum,Y_cyc,Y_lit1,Y_lit2,Y_lit3);
    A=0; B=1; #20;
    $display("%0d  %0d |  %0d  |  %0d   |  %0d  |  %0d   |  %0d   |  %0d",
             A,B,Y_min,Y_tsum,Y_cyc,Y_lit1,Y_lit2,Y_lit3);
    A=1; B=1; #20;
    $display("%0d  %0d |  %0d  |  %0d   |  %0d  |  %0d   |  %0d   |  %0d",
             A,B,Y_min,Y_tsum,Y_cyc,Y_lit1,Y_lit2,Y_lit3);
    A=1; B=2; #20;
    $display("%0d  %0d |  %0d  |  %0d   |  %0d  |  %0d   |  %0d   |  %0d",
             A,B,Y_min,Y_tsum,Y_cyc,Y_lit1,Y_lit2,Y_lit3);
    A=2; B=2; #20;
    $display("%0d  %0d |  %0d  |  %0d   |  %0d  |  %0d   |  %0d   |  %0d",
             A,B,Y_min,Y_tsum,Y_cyc,Y_lit1,Y_lit2,Y_lit3);
    A=2; B=3; #20;
    $display("%0d  %0d |  %0d  |  %0d   |  %0d  |  %0d   |  %0d   |  %0d",
             A,B,Y_min,Y_tsum,Y_cyc,Y_lit1,Y_lit2,Y_lit3);
    A=3; B=3; #20;
    $display("%0d  %0d |  %0d  |  %0d   |  %0d  |  %0d   |  %0d   |  %0d",
             A,B,Y_min,Y_tsum,Y_cyc,Y_lit1,Y_lit2,Y_lit3);
    A=3; B=0; #20;
    $display("%0d  %0d |  %0d  |  %0d   |  %0d  |  %0d   |  %0d   |  %0d",
             A,B,Y_min,Y_tsum,Y_cyc,Y_lit1,Y_lit2,Y_lit3);

    $finish;
  end
endmodule

