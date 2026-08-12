module quat_alu_complete(
  input  [1:0] A,
  input  [1:0] B,
  input  [2:0] opcode,
  output reg [1:0] Result,
  output reg       Zero,
  output reg       Carry
);
  wire [1:0] w_max, w_min, w_suc, w_tsum;
  wire [1:0] w_and1, w_and2, w_and3;
  wire [3:0] w_add;
  wire le;
  wire eq;
  quat_max  U_MAX(.A(A), .B(B), .Y(w_max));
  quat_min  U_MIN(.A(A), .B(B), .Y(w_min));
  quat_suc  U_SUC(.A(A), .Y(w_suc));
  quat_tsum U_TS (.A(A), .B(B), .Y(w_tsum));
  eAND1     U_E1 (.A(A), .B(B), .Y(w_and1));
  eAND2     U_E2 (.A(A), .B(B), .Y(w_and2));
  eAND3     U_E3 (.A(A), .B(B), .Y(w_and3));
  bit2LessThanEqualTo U_CMP(.A(A), .B(B), .Y(le));
  bit2Equal U_EQ(.A(A),.B(B),.Y(eq));
  assign w_add = {2'b00, A} + {2'b00, B};

  always @(*) begin
    Carry = 0;
    case(opcode)
      3'b000: begin
                Result = w_add[1:0];
                Carry  = (w_add[3:2] > 0) ? 1'b1 : 1'b0;
              end
      3'b001: Result = w_max;
      3'b010: Result = w_min;
      3'b011: Result = w_suc;
      3'b100: Result = w_tsum;
      3'b101: Result = w_and1 | w_and2 | w_and3;
      3'b110: Result = (~le) ? 2'd1 : 2'd0;
      3'b111: Result = (eq) ? 2'd3 : 2'd0;
      default: Result = 2'd0;
    endcase
    Zero = (Result == 2'd0) ? 1'b1 : 1'b0;
  end
endmodule