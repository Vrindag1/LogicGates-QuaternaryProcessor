
module tb_primitives;
  reg  [1:0] A, B;
  wire [1:0] Y_max, Y_suc, Y_and1, Y_and2, Y_and3;

  // Instantiate all 5 cells
  quat_max  U_MAX (.A(A),.B(B),.Y(Y_max));
  quat_suc  U_SUC (.A(A),.Y(Y_suc));
  eAND1     U_E1  (.A(A),.B(B),.Y(Y_and1));
  eAND2     U_E2  (.A(A),.B(B),.Y(Y_and2));
  eAND3     U_E3  (.A(A),.B(B),.Y(Y_and3));

  integer i, j;
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_primitives);

    $display("=== QUATERNARY PRIMITIVE CELL VERIFICATION ===");
    $display("A  B | MAX | SUC(A) | eAND1 | eAND2 | eAND3");
    $display("-----|-----|--------|-------|-------|------");

    for(i = 0; i < 4; i = i+1) begin
      for(j = 0; j < 4; j = j+1) begin
        A = i[1:0];
        B = j[1:0];
        #10;
        $display("%0d  %0d |  %0d  |   %0d    |   %0d   |   %0d   |   %0d",
          A, B, Y_max, Y_suc, Y_and1, Y_and2, Y_and3);
      end
    end
    $display("=== DONE ===");
    $finish;
  end
endmodule
