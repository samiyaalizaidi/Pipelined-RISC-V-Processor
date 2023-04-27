`timescale 1ns / 1ps

module IF_ID_Reg(
    input clk, 
    input [63:0] PC,
    input [31:0] Instruction,
    
    output reg [63:0] PC_Stored,
    output reg [31:0] Instruction_Stored
    );
    
    always @ (negedge clk)
    begin
        PC_Stored = PC;
        Instruction_Stored = Instruction;
    end
endmodule
