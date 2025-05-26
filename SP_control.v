`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2024 01:18:25
// Design Name: 
// Module Name: SP_control
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


module SP_control(operation, clk, rst, in, out, pointer); 
    input [2:0] operation; 
    input clk, rst;
    input [31:0] in; // will be obtained from Rs/Rt
    output reg [31:0] out; // will be used to update SP 
    output reg [31:0] pointer; // will be used to update memory

    wire [31:0] tempSP;

    initial begin 
        out <= 1023;
    end
        always @(posedge clk) begin
        if (rst) begin
            out <= 1023;
        end
        else begin
            case (operation)
                // 001 -> PUSH
                3'b001: begin
                    out <= in - 1;
                    pointer <= in - 1; // Mem [SP] <= R[Rs]
                end

                // 010 -> POP
                3'b010: begin
                    pointer <= in; // LMD <= Mem [SP]
                    out <= in + 1;
                end

                // 011 -> CALL
                3'b011: begin
                    out <= in - 1;
                    pointer <= in - 1; // Mem [SP] <= NPC (PC + 1)
                    // PC <= ALUOut - done in PC_control
                end

                // 100 -> RET
                3'b100: begin
                    pointer <= in; // LMD <= Mem [SP]
                    out <= in + 1;
                end
            endcase
        end
    end


endmodule
