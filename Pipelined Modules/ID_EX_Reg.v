`timescale 1ns / 1ps

module ID_EX_Reg(
    input clk, 
    input [63:0] PC, Read_Data_1, Read_Data_2, imm_value,
    input [3:0] Funct,
    input [4:0] RD,
    input MemtoReg, RegWrite, Branch, MemWrite, MemRead, ALUSrc, 
    input [1:0] ALU_OP,
    
    output reg [63:0] PC_Stored, Read_Data_1_S, Read_Data_2_S, imm_value_S,
    output reg [3:0] Funct_S,
    output reg [4:0] RD_S,
    output reg MemtoReg_S, RegWrite_S, Branch_S, MemWrite_S, MemRead_S, ALUSrc_S, 
    output reg [1:0] ALU_OP_S
);

    always @ (negedge clk)
    begin
        PC_Stored = PC;
        Read_Data_1_S = Read_Data_1;
        Read_Data_2_S = Read_Data_2;
        imm_value_S = imm_value;
        Funct_S = Funct;
        RD_S = RD;
        RegWrite_S = RegWrite;
        MemtoReg_S= MemtoReg;
        Branch_S = Branch;
        MemWrite_S = MemWrite;
        MemRead_S = MemRead;
        ALUSrc_S = ALUSrc;
        ALU_OP_S = ALU_OP;
    end
    
endmodule 
