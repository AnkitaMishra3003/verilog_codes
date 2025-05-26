`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2024 01:21:30
// Design Name: 
// Module Name: program_counter
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


module program_counter(instruction, in, ld, rst, clk, out);
    input [31:0] instruction;
    input [31:0] in;
    input ld;
    input rst,clk;
    output reg [31:0] out;

    initial begin 
        out <= 0; 
    end

    always @(posedge clk)
    begin
        if(rst) begin
            out <= 0;
        end
        else if (ld) begin
//            $display("UPDATING PC to %d", in);
            out <= in;
        end
    end
endmodule
