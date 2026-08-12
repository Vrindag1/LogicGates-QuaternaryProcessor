module quat_alu_wide(
  input  [7:0] A,
  input  [7:0] B,
  input  [2:0] opcode,
  output reg [7:0] Result,
  output reg       Zero,
  output reg       Carry
);
  // 4-digit operations
  wire [7:0] add_sum;
  wire [1:0] add_cout;

  // MAX and MIN digit by digit
  wire [1:0] max0,max1,max2,max3;
  wire [1:0] min0,min1,min2,min3;

  // SUC on each digit
  wire [1:0] suc0,suc1,suc2,suc3;

  // Instantiate 4-digit adder
  quat_add4 ADD4(
    .A(A),.B(B),
    .Sum(add_sum),.Cout(add_cout)
  );

  // MAX digit by digit
  quat_max MX0(.A(A[1:0]),.B(B[1:0]),.Y(max0));
  quat_max MX1(.A(A[3:2]),.B(B[3:2]),.Y(max1));
  quat_max MX2(.A(A[5:4]),.B(B[5:4]),.Y(max2));
  quat_max MX3(.A(A[7:6]),.B(B[7:6]),.Y(max3));

  // MIN digit by digit
  quat_min MN0(.A(A[1:0]),.B(B[1:0]),.Y(min0));
  quat_min MN1(.A(A[3:2]),.B(B[3:2]),.Y(min1));
  quat_min MN2(.A(A[5:4]),.B(B[5:4]),.Y(min2));
  quat_min MN3(.A(A[7:6]),.B(B[7:6]),.Y(min3));

  // SUC digit by digit
  quat_suc SC0(.A(A[1:0]),.Y(suc0));
  quat_suc SC1(.A(A[3:2]),.Y(suc1));
  quat_suc SC2(.A(A[5:4]),.Y(suc2));
  quat_suc SC3(.A(A[7:6]),.Y(suc3));

  always @(*) begin
    Carry = 0;
    case(opcode)
      3'b000: begin                          // ADD all 4 digits
                Result = add_sum;
                Carry  = (add_cout > 0);
              end
      3'b001: Result = {max3,max2,max1,max0}; // MAX per digit
      3'b010: Result = {min3,min2,min1,min0}; // MIN per digit
      3'b011: Result = {suc3,suc2,suc1,suc0}; // SUC per digit
      3'b100: begin                            // Compare MSB digit
                Result = (A > B) ? 8'd1 : 8'd0;
              end
      3'b101: begin                            // Equal check
                Result = (A == B) ? 8'd3 : 8'd0;
              end
      3'b110: Result = A;                      // PASS A (for MOV)
      3'b111: Result = 8'd0;                   // ZERO
      default: Result = 8'd0;
    endcase
    Zero = (Result == 8'd0);
  end
endmodule
