module quat_cpu16(
  input clk,
  input rst
);
  // Program Counter
  reg [3:0] PC;

  // Pipeline registers IF/ID
  reg [15:0] IF_ID_instr;

  // Pipeline registers ID/EX
  reg [15:0] ID_EX_instr;
  reg [7:0]  ID_EX_rs1_data;
  reg [7:0]  ID_EX_rs2_data;
  reg [2:0] ID_EX_alu_op;
  reg       ID_EX_reg_write;
  reg       ID_EX_is_mov;

  // Pipeline registers EX/WB
  reg [7:0]  EX_WB_result;
  reg [3:0]  EX_WB_rd;
  reg        EX_WB_reg_write;

  // Instruction fields
  wire [3:0] opcode = IF_ID_instr[15:12];
  wire [3:0] rs1    = IF_ID_instr[11:8];
  wire [3:0] rs2    = IF_ID_instr[7:4];
  wire [3:0] rd     = IF_ID_instr[3:0];

  // Control signals
  wire [2:0] alu_op;
  wire       reg_write, is_mov;

  // Data wires
  wire [15:0] instr;
  wire [7:0]  rs1_data, rs2_data;
  wire [7:0]  alu_result_wide;
  wire        zero, carry;

  // Modules
  quat_imem16 IMEM(.addr(PC), .instr(instr));

  quat_regfile RF(
    .clk(clk), .rst(rst),
    .we(EX_WB_reg_write),
    .rd_addr1(rs1),
    .rd_addr2(rs2),
    .wr_addr(EX_WB_rd),
    .wr_data(EX_WB_result),
    .rd_data1(rs1_data),
    .rd_data2(rs2_data)
  );

  quat_control16 CTRL(
    .opcode(opcode),
    .alu_op(alu_op),
    .reg_write(reg_write),
    .is_mov(is_mov)
  );

  quat_alu_wide ALU(
    .A(ID_EX_rs1_data),
    .B(ID_EX_rs2_data),
    .opcode(ID_EX_alu_op),
    .Result(alu_result_wide),
    .Zero(zero),
    .Carry(carry)
  );

  // IF Stage
  always @(posedge clk or posedge rst) begin
    if(rst) begin
      PC          <= 4'd0;
      IF_ID_instr <= 16'd0;
    end else begin
      IF_ID_instr <= instr;
      PC          <= PC + 1;
    end
  end

  // ID Stage
  always @(posedge clk or posedge rst) begin
    if(rst) begin
      ID_EX_instr    <= 16'd0;
      ID_EX_rs1_data <= 8'd0;
      ID_EX_rs2_data <= 8'd0;
      ID_EX_alu_op     <= 3'b000;
      ID_EX_reg_write  <= 1'b0;
      ID_EX_is_mov     <= 1'b0;
    end else begin
      ID_EX_instr    <= IF_ID_instr;
      ID_EX_rs1_data <= rs1_data;
      ID_EX_rs2_data <= rs2_data;
      ID_EX_alu_op     <= alu_op;
      ID_EX_reg_write  <= reg_write;
      ID_EX_is_mov     <= is_mov;

    end
  end

  // EX + WB Stage
  always @(posedge clk or posedge rst) begin
    if(rst) begin
      EX_WB_result    <= 8'd0;
      EX_WB_rd        <= 4'd0;
      EX_WB_reg_write <= 1'b0;
    end else begin
      if(ID_EX_is_mov)
        EX_WB_result <= ID_EX_rs1_data;
      else
        EX_WB_result <=  alu_result_wide;
      EX_WB_rd        <= ID_EX_instr[3:0];
      EX_WB_reg_write <= ID_EX_reg_write;
    end
  end

endmodule
