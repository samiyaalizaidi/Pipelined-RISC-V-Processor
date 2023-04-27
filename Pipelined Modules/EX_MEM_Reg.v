`timescale 1ns / 1ps

module EX_MEM_Reg(
    input clk,
    input [63:0] PC,
    input RegWrite, MemWrite, Branch, ZERO, MemtoReg, MemRead,
    input [63:0] Result, Write_Data_Mem, Branch_Address,
    input [3:0] Funct,
    input [4:0] RD,
     
    output reg [63:0] PC_Stored,
    output reg  RegWrite_S, MemWrite_S, Branch_S, ZERO_S, MemtoReg_S, MemRead_S,
    output reg [63:0] Result_S, Write_Data_Mem_S, Branch_Address_S,
    output reg [3:0] Funct_S,
    output reg [4:0] RD_S
);
    
    always @(negedge clk) begin
        RegWrite_S = RegWrite;
        MemtoReg_S = MemtoReg;
        Branch_S = Branch;
        ZERO_S = ZERO;
        MemWrite_S = MemWrite;
        MemRead_S = MemRead;
        Branch_Address_S = Branch_Address;
        Result_S = Result;
        Write_Data_Mem_S = Write_Data_Mem;
        Funct_S = Funct;
        RD_S = RD;
    end
    
endmodule
