// Decoding the instruction into op, funct, Rs, Rt, Rd, Shift, immediate

module instruction_decoder (instruction,op,Rs,Rt,Rd,Shift,funct,immediate);
    input [31:0] instruction;
    output reg [5:0] op,funct;
    output reg [4:0] Rs,Rt,Rd,Shift;
    output reg [31:0] immediate;

    parameter 
        REG = 6'b000000,

        ADDI =  6'b000001,
        SUBI =  6'b000010,
        ANDI =  6'b000011,
        ORI =   6'b000100,
        XORI = 6'b000101,
        NOTI = 6'b000110,
        SLAI = 6'b000111,
        SRLI = 6'b001000,
        SRAI = 6'b001001,
        NORI = 6'b011001,
        SLTI = 6'b011010,
        SGTI = 6'b011011,

        BR =   6'b001010,
        BMI =  6'b001011,
        BPL =  6'b001100,
        BZ =   6'b001101,

        LD =  6'b001110,
        ST =  6'b001111,

        MOVE = 6'b010010,

        PUSH = 6'b010011,
        POP = 6'b010100,
        CALL = 6'b010101, 

        HALT = 6'b010110,
        NOP = 6'b010111,
        RET = 6'b011000;

   always @(*)
        begin
            op <= instruction[31:26];
            case(op)
                // R-type instructions - arithmetic operations
                REG: begin
                    Rs <= instruction[25:21];
                    Rt <= instruction[20:16];
                    Rd <= instruction[15:11];
                    Shift <= instruction[10:6];
                    funct <= instruction[5:0];
                    immediate <= 0;
                end

                // PUSH (instruction of type PUSH Rt)
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                PUSH: begin
                    Rs <= 16;
                    Rt <= instruction[25:21];
                    Rd <= 16;
                    Shift <= 0;
                    funct <= 0;
                    immediate <= 0; // not used
                end

                // POP (instruction of type POP Rt)
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                POP: begin
                    Rs <= 16;
                    Rt <= instruction[25:21];
                    Rd <= 16;
                    Shift <= 0;
                    funct <= 0;
                    immediate <= 0; // not used
                end

                // CALL (instruction of type CALL immediate)
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                CALL: begin
                    Rs <= 16;
                    Rt <= 0;
                    Rd <= 16;
                    Shift <= 0;
                    funct <= 0;
                    immediate <= { {16{instruction[15]}} , instruction[15:0]};
                end

                // RET
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                RET: begin
                    Rs <= 16;
                    Rt <= 0;
                    Rd <= 16;
                    Shift <= 0;
                    funct <= 0;
                    immediate <= 0;
                end

                // HALT
                HALT: begin
                    Rs <= 0;
                    Rt <= 0;
                    Rd <= 0;
                    Shift <= 0;
                    funct <= 0;
                    immediate <= 0;
                end

                // NOP
                NOP: begin
                    Rs <= 0;
                    Rt <= 0;
                    Rd <= 0;
                    Shift <= 0;
                    funct <= 0;
                    immediate <= 0;
                end
                


                // other I-type instructions 
                default: begin
                    Rs <= instruction[25:21];
                    Rt <= instruction[20:16];
                    Rd <= 0;
                    // in case of shift operations, Shift is the "immediate" field
                    if (op == SRAI || op == SLAI || op == SRLI) Shift <= instruction[4:0];
                    else Shift <= 0;
                    funct <= 0;
                    if (op == MOVE) immediate <= 0; // implementing MOVE as ADDI with immediate = 0
                    else immediate <= { {16{instruction[15]}} , instruction[15:0]};
                end
                
            endcase
        end
endmodule