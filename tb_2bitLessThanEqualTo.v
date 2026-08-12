module tb_bit2LessThanEqualTo;
  reg  [1:0] A, B;
  wire Y;
  reg expected; 
   bit2LessThanEqualTo uut (.A(A),.B(B),.Y(Y));
   integer i, j;

    initial begin
        $dumpfile("bit2LessThanEqualTo.vcd");
        $dumpvars(0, tb_bit2LessThanEqualTo);
        $display("========================================");
        $display(" A   B   Y   Expected   Status");
        $display("========================================");

        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin

                A = i;
                B = j;
                #10;

                expected = (A <= B);

                if (Y == expected)
                    $display("%2d  %2d   %b      %b       PASS",
                             A, B, Y, expected);
                else
                    $display("%2d  %2d   %b      %b       FAIL",
                             A, B, Y, expected);

            end
        end
        $finish;

  end
endmodule