module tb_regfile;
  reg        clk, rst, we;
  reg  [3:0] rd_addr1, rd_addr2, wr_addr;
  reg  [7:0] wr_data;
  wire [7:0] rd_data1, rd_data2;

  quat_regfile RF(
    .clk(clk), .rst(rst), .we(we),
    .rd_addr1(rd_addr1), .rd_addr2(rd_addr2),
    .wr_addr(wr_addr),   .wr_data(wr_data),
    .rd_data1(rd_data1), .rd_data2(rd_data2)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_regfile);

    // Initialize everything
    clk = 0; rst = 1; we = 0;
    rd_addr1 = 0; rd_addr2 = 0;
    wr_addr = 0; wr_data = 0;

    // Hold reset for 2 clock cycles
    #20 rst = 0;

    $display("=== REGISTER FILE TEST ===");

    // Write to reg 0: value 8'b01_10_01_00
    we = 1; wr_addr = 4'd0; wr_data = 8'b01_10_01_00;
    @(posedge clk); #1;

    // Write to reg 1: value 8'b11_11_00_01
    wr_addr = 4'd1; wr_data = 8'b11_11_00_01;
    @(posedge clk); #1;

    // Write to reg 2: value 8'b10_10_10_10
    wr_addr = 4'd2; wr_data = 8'b10_10_10_10;
    @(posedge clk); #1;

    // Stop writing
    we = 0;
    #2;

    // Read back reg 0 and reg 1
    rd_addr1 = 4'd0; rd_addr2 = 4'd1;
    #5;
    $display("Reg0 = %b  (expect 01100100)", rd_data1);
    $display("Reg1 = %b  (expect 11110001)", rd_data2);

    // Read back reg 2 and reg 3 (never written = 0)
    rd_addr1 = 4'd2; rd_addr2 = 4'd3;
    #5;
    $display("Reg2 = %b  (expect 10101010)", rd_data1);
    $display("Reg3 = %b  (expect 00000000)", rd_data2);

    $display("=== DONE ===");
    $finish;
  end
endmodule