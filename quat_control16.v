module quat_control16(
  input  [3:0] opcode,
  output reg [2:0] alu_op,
  output reg       reg_write,
  output reg       is_mov
);
  always @(*) begin
    alu_op    = 3'b000;
    reg_write = 1'b0;
    is_mov    = 1'b0;

    case(opcode)
      4'b0000: begin alu_op=3'b000; reg_write=1'b1; end // ADD
      4'b0001: begin alu_op=3'b001; reg_write=1'b1; end // MAX
      4'b0010: begin alu_op=3'b010; reg_write=1'b1; end // MIN
      4'b0011: begin alu_op=3'b000; reg_write=1'b1;     // MOV
                     is_mov=1'b1; end
      4'b0100: begin alu_op=3'b100; reg_write=1'b1; end // TSUM
      4'b0101: begin alu_op=3'b110; reg_write=1'b1; end // CMP
      4'b0110: begin reg_write=1'b0; end                 // NOP
      default: begin reg_write=1'b0; end
    endcase
  end
endmodule
