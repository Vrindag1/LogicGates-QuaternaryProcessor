module quat_regfile(
  input        clk,
  input        rst,
  input        we,
  input  [3:0] rd_addr1,
  input  [3:0] rd_addr2,
  input  [3:0] wr_addr,
  input  [7:0] wr_data,
  output [7:0] rd_data1,
  output [7:0] rd_data2
);
  reg [7:0] regs [0:15];
  integer i;
  initial begin
    for(i = 0; i < 16; i = i + 1)
    regs[i] = 8'd0;
    // Seed for Fibonacci: r0=0, r1=1
    regs[0] = 8'b00_00_00_00;
    regs[1] = 8'b00_00_00_01;
    end
    always @(posedge clk or posedge rst) begin
      if(rst) begin
        for(i = 0; i < 16; i = i + 1)
        regs[i] <= 8'd0;
        regs[1] <= 8'd1;
        end
        else if(we)
        regs[wr_addr] <= wr_data;
        end
        assign rd_data1 = regs[rd_addr1];
        assign rd_data2 = regs[rd_addr2];
endmodule
