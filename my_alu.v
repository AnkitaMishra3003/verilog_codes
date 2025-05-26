module XOR(
    input [31:0] A,
    input [31:0] B,
    output [31:0] Z
);
    xor a1(Z[0],  A[0],  B[0]);
    xor a2(Z[1],  A[1],  B[1]);
    xor a3(Z[2],  A[2],  B[2]);
    xor a4(Z[3],  A[3],  B[3]);
    xor a5(Z[4],  A[4],  B[4]);
    xor a6(Z[5],  A[5],  B[5]);
    xor a7(Z[6],  A[6],  B[6]);
    xor a8(Z[7],  A[7],  B[7]);
    xor a9(Z[8],  A[8],  B[8]);
    xor a10(Z[9], A[9],  B[9]);
    xor a11(Z[10], A[10], B[10]);
    xor a12(Z[11], A[11], B[11]);
    xor a13(Z[12], A[12], B[12]);
    xor a14(Z[13], A[13], B[13]);
    xor a15(Z[14], A[14], B[14]);
    xor a16(Z[15], A[15], B[15]);
    xor a17(Z[16], A[16], B[16]);
    xor a18(Z[17], A[17], B[17]);
    xor a19(Z[18], A[18], B[18]);
    xor a20(Z[19], A[19], B[19]);
    xor a21(Z[20], A[20], B[20]);
    xor a22(Z[21], A[21], B[21]);
    xor a23(Z[22], A[22], B[22]);
    xor a24(Z[23], A[23], B[23]);
    xor a25(Z[24], A[24], B[24]);
    xor a26(Z[25], A[25], B[25]);
    xor a27(Z[26], A[26], B[26]);
    xor a28(Z[27], A[27], B[27]);
    xor a29(Z[28], A[28], B[28]);
    xor a30(Z[29], A[29], B[29]);
    xor a31(Z[30], A[30], B[30]);
    xor a32(Z[31], A[31], B[31]);
endmodule



module full(cout, s, c, a, b);
    input a, b, c;
    output s, cout;
    
    xor x1(s, a, b, c);
    and a1(t1, a, b);
    and a2(t2, a, c);
    and a3(t3, b, c);
    or o1(cout, t1, t2, t3);
endmodule

module full32(
    output cout,          // Final carry-out
    output [31:0] S,      // 32-bit sum output
    input [31:0] A,       // 32-bit input A
    input [31:0] B,       // 32-bit input B
    input C               // Carry-in for the least significant bit
);

    wire [31:0] c;        // Internal carry wires

    // Instantiate the 1-bit full adders for 32 bits
    full f1(c[0], S[0], C, A[0], B[0]);
    full f2(c[1], S[1], c[0], A[1], B[1]);
    full f3(c[2], S[2], c[1], A[2], B[2]);
    full f4(c[3], S[3], c[2], A[3], B[3]);
    full f5(c[4], S[4], c[3], A[4], B[4]);
    full f6(c[5], S[5], c[4], A[5], B[5]);
    full f7(c[6], S[6], c[5], A[6], B[6]);
    full f8(c[7], S[7], c[6], A[7], B[7]);
    full f9(c[8], S[8], c[7], A[8], B[8]);
    full f10(c[9], S[9], c[8], A[9], B[9]);
    full f11(c[10], S[10], c[9], A[10], B[10]);
    full f12(c[11], S[11], c[10], A[11], B[11]);
    full f13(c[12], S[12], c[11], A[12], B[12]);
    full f14(c[13], S[13], c[12], A[13], B[13]);
    full f15(c[14], S[14], c[13], A[14], B[14]);
    full f16(c[15], S[15], c[14], A[15], B[15]);
    full f17(c[16], S[16], c[15], A[16], B[16]);
    full f18(c[17], S[17], c[16], A[17], B[17]);
    full f19(c[18], S[18], c[17], A[18], B[18]);
    full f20(c[19], S[19], c[18], A[19], B[19]);
    full f21(c[20], S[20], c[19], A[20], B[20]);
    full f22(c[21], S[21], c[20], A[21], B[21]);
    full f23(c[22], S[22], c[21], A[22], B[22]);
    full f24(c[23], S[23], c[22], A[23], B[23]);
    full f25(c[24], S[24], c[23], A[24], B[24]);
    full f26(c[25], S[25], c[24], A[25], B[25]);
    full f27(c[26], S[26], c[25], A[26], B[26]);
    full f28(c[27], S[27], c[26], A[27], B[27]);
    full f29(c[28], S[28], c[27], A[28], B[28]);
    full f30(c[29], S[29], c[28], A[29], B[29]);
    full f31(c[30], S[30], c[29], A[30], B[30]);
    full f32(cout, S[31], c[30], A[31], B[31]);

endmodule

module full_adder(
    output cout,  // Carry-out
    output sum,   // Sum
    input a,      // Input A
    input b,      // Input B
    input cin     // Carry-in
);

    assign {cout, sum} = a + b + cin;

endmodule

module subtractor_32bit(
    output [31:0] diff,  // 32-bit difference (A - B)
    output cout,         // Carry-out (can indicate overflow)
    input [31:0] A,      // 32-bit input A (minuend)
    input [31:0] B       // 32-bit input B (subtrahend)
);

    wire [31:0] B_complement;  // Two's complement of B
    wire [31:0] carry;         // Carry signals between full adders

    // Invert each bit of B to get one's complement
    assign B_complement = ~B;

    // Full adder for the least significant bit with carry-in of 1 (for two's complement)
    full_adder fa0(carry[0], diff[0], A[0], B_complement[0], 1'b1);

    // Full adders for the remaining bits with carry propagation
    full_adder fa1(carry[1], diff[1], A[1], B_complement[1], carry[0]);
    full_adder fa2(carry[2], diff[2], A[2], B_complement[2], carry[1]);
    full_adder fa3(carry[3], diff[3], A[3], B_complement[3], carry[2]);
    full_adder fa4(carry[4], diff[4], A[4], B_complement[4], carry[3]);
    full_adder fa5(carry[5], diff[5], A[5], B_complement[5], carry[4]);
    full_adder fa6(carry[6], diff[6], A[6], B_complement[6], carry[5]);
    full_adder fa7(carry[7], diff[7], A[7], B_complement[7], carry[6]);
    full_adder fa8(carry[8], diff[8], A[8], B_complement[8], carry[7]);
    full_adder fa9(carry[9], diff[9], A[9], B_complement[9], carry[8]);
    full_adder fa10(carry[10], diff[10], A[10], B_complement[10], carry[9]);
    full_adder fa11(carry[11], diff[11], A[11], B_complement[11], carry[10]);
    full_adder fa12(carry[12], diff[12], A[12], B_complement[12], carry[11]);
    full_adder fa13(carry[13], diff[13], A[13], B_complement[13], carry[12]);
    full_adder fa14(carry[14], diff[14], A[14], B_complement[14], carry[13]);
    full_adder fa15(carry[15], diff[15], A[15], B_complement[15], carry[14]);
    full_adder fa16(carry[16], diff[16], A[16], B_complement[16], carry[15]);
    full_adder fa17(carry[17], diff[17], A[17], B_complement[17], carry[16]);
    full_adder fa18(carry[18], diff[18], A[18], B_complement[18], carry[17]);
    full_adder fa19(carry[19], diff[19], A[19], B_complement[19], carry[18]);
    full_adder fa20(carry[20], diff[20], A[20], B_complement[20], carry[19]);
    full_adder fa21(carry[21], diff[21], A[21], B_complement[21], carry[20]);
    full_adder fa22(carry[22], diff[22], A[22], B_complement[22], carry[21]);
    full_adder fa23(carry[23], diff[23], A[23], B_complement[23], carry[22]);
    full_adder fa24(carry[24], diff[24], A[24], B_complement[24], carry[23]);
    full_adder fa25(carry[25], diff[25], A[25], B_complement[25], carry[24]);
    full_adder fa26(carry[26], diff[26], A[26], B_complement[26], carry[25]);
    full_adder fa27(carry[27], diff[27], A[27], B_complement[27], carry[26]);
    full_adder fa28(carry[28], diff[28], A[28], B_complement[28], carry[27]);
    full_adder fa29(carry[29], diff[29], A[29], B_complement[29], carry[28]);
    full_adder fa30(carry[30], diff[30], A[30], B_complement[30], carry[29]);
    full_adder fa31(cout, diff[31], A[31], B_complement[31], carry[30]);

endmodule

module SUB(
    input [31:0] A,     // 32-bit input A
    input [31:0] B,     // 32-bit input B
    output [31:0] Z     // 32-bit output Z (difference)
);
    wire cout;
    subtractor_32bit s1(Z, cout, A, B); // 32-bit subtraction
endmodule



module ADD(
    input [31:0] A,       // 32-bit input A
    input [31:0] B,       // 32-bit input B
    output [31:0] Z       // 32-bit sum output
);
    wire cout;
    full32 f(cout, Z, A, B, 0); // 32-bit addition
endmodule


module my_alu(
    input [31:0] a,      // 32-bit input A
    input [31:0] b,      // 32-bit input B
    input [3:0] cmd,     // 4-bit command input
    output reg [31:0] Z  // 32-bit output Z
);

    wire [31:0] add_result, sub_result, and_result, or_result, xor_result;
    wire [31:0] shift_left_result, shift_right_logical_result, shift_right_arith_result;
    wire [31:0] inc_result, dec_result, hamming_result;
    wire [31:0] mult_result, div_result;
    wire [31:0] A, B;
    wire [31:0] Command;

    assign A = a;
    assign B = b;
    assign Command = {28'b0000000000000000000000000000, cmd};

    // Instantiate the modules
    ADD add_module(.A(A), .B(B), .Z(add_result));
    SUB sub_module(.A(A), .B(B), .Z(sub_result));
    AND and_module(.A(A), .B(B), .Z(and_result));
    OR or_module(.A(A), .B(B), .Z(or_result));
    XOR xor_module(.A(A), .B(B), .Z(xor_result));
    SHIFT_LEFT shift_left_module(.B(A), .Shift(B), .Result(shift_left_result));
    SHIFT_RIGHT shift_right_logical_module(.B(A), .Shift(B), .Result(shift_right_logical_result));
    SHIFT_RIGHT_ARITH shift_right_arith_module(.B(A), .Shift(B), .Result(shift_right_arith_result));
    INC inc_module(.A(A), .Z(inc_result));
    DEC dec_module(.A(A), .Z(dec_result));
    //HAMMING_WEIGHT hamming_module(.A(A), .Z(hamming_result));
    MULT mult_module(.A(A), .B(B), .Z(mult_result)); // Behavioral
    DIV div_module(.A(A), .B(B), .Z(div_result)); // Behavioral

    always @(*) begin
        case (Command[3:0])
            4'b0000: Z = add_result;             // A + B
            4'b0001: Z = sub_result;             // A - B
            4'b0010: Z = mult_result;            // A * B
            4'b0011: Z = div_result;             // A / B
            4'b0100: Z = and_result;             // A & B
            4'b0101: Z = or_result;              // A | B
            4'b0110: Z = xor_result;             // A ^ B
            4'b0111: Z = ~A;                     // ~A
            4'b1000: Z = A;                      // A
            4'b1001: Z = B;                      // B
            4'b1010: Z = shift_left_result;      // A << B
            4'b1011: Z = shift_right_logical_result; // A >> B (logical)
            4'b1100: Z = shift_right_arith_result;   // A >> B (arithmetic)
            4'b1101: Z = inc_result;             // A + 4
            4'b1110: Z = dec_result;             // A - 4
            4'b1111: Z = 32'b00000000000000000000000000000000;         // HAM(A)
            default: Z = 32'b00000000000000000000000000000000; // Default case
        endcase
    end
endmodule
