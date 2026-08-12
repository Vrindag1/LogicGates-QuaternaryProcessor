module tb_cpu16;
  reg clk, rst;
  integer cycle;

  quat_cpu16 CPU(.clk(clk), .rst(rst));

  always #5 clk = ~clk;

  wire [7:0] r0 = CPU.RF.regs[0];
  wire [7:0] r1 = CPU.RF.regs[1];
  wire [7:0] r2 = CPU.RF.regs[2];

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_cpu16);
    clk = 0; rst = 1; cycle = 0;
    // Hold reset for 4 clock cycles
    #40 rst = 0;
    $display("=== 16-BIT QUATERNARY CPU - FIBONACCI ===");
    $display("Cycle | PC | Opcode | isMOV | R0 | R1 | R2");
    $display("------+----+--------+-------+----+----+---");

    repeat(24) begin
      @(posedge clk); #1;
      cycle = cycle + 1;
      $display("  %2d  | %2d |  %4b  |   %1b   | %2d | %2d | %2d",
               cycle,
               CPU.PC,
               CPU.ID_EX_instr[15:12],
               CPU.ID_EX_is_mov,
               r0[1:0],
               r1[1:0],
               r2[1:0]);
    end

    $display("------+----+--------+-------+----+----+---");
    $display("FINAL: R0=%0d R1=%0d R2=%0d",
             r0[1:0], r1[1:0], r2[1:0]);
    $display("Fibonacci in quaternary: 0,1,1,2,3");
    $display("=== DONE ===");
    $finish;
  end
endmodule