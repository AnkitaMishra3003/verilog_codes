`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2024 01:17:46
// Design Name: 
// Module Name: PC_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC_control(Branchoperation, StackOperation, ALUOut, regvalue, lmd, in, rst, clk, out);
    input [2:0] Branchoperation;
    input [2:0] StackOperation;
    input [31:0] ALUOut;   // computed using ALU
    input signed [31:0] regvalue;   // will get from opcode computation
    input [31:0] lmd;      // memory output
    input [31:0] in;
    input rst, clk;
    output reg [31:0] out; 

    initial begin 
        out <= 0; 
    end

    always @(posedge clk) begin
        // $display("Branchoperation = %d, StackOperation = %d, ALUOut = %d, in = %d", Branchoperation, StackOperation, ALUOut, in);
        if (rst) begin
            out <= 0;
        end
        else begin
            case (Branchoperation)
               // 001 -> BR (unconditional branch)
                3'b001: begin
                    $display("BR: branching to %d from %d", ALUOut, in);
                    out <= ALUOut; 
                end

                3'b010: begin
                    // 010 -> BPL (branch if positive)
                    if (regvalue > 0) begin
                        out <= ALUOut;
                    end
                    else begin
                        out <= in + 1;
                    end 
                end

                3'b011: begin
                    // 011 -> BMI
                    if (regvalue < 0) begin
                        out <= ALUOut;
                    end
                    else begin
                        out <= in + 1;
                    end
                end

                3'b100: begin
                    // 100 -> BZ (branch if zero)
                    if (regvalue == 0) begin
                        $display("BZ: branching to %d from %d", ALUOut, in);
                    
                        out <= ALUOut;
                    end
                    else begin
                        out <= in + 1;
                    end
                end

                3'b000: begin 
                    // not a branching operation, but PC could change because of it being a stack operation 
                    case(StackOperation)
                        // 001 -> PUSH
                        3'b001: begin
                            out <= in + 1;
                        end

                        // 010 -> POP
                        3'b010: begin
                            out <= in + 1;
                        end

                        // 011 -> CALL
                        3'b011: begin
                            out <= ALUOut;
                        end

                        // 100 -> RET
                        3'b100: begin
                            out <= lmd; // check this
                        end

                        // default 
                        default: begin  
                            out <= in + 1;
                        end
                    endcase
                end
            endcase 
        end
        end
endmodule
