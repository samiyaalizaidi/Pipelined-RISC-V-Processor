`timescale 1ns / 1ps

module MEM_WB_Reg(
    input clk, 
    input RegWrite, MemtoReg,
    input [63:0] Read_Data_Memory, Result, 
    input [4:0] RD,
    
    output reg RegWrite_S, MemtoReg_S,
    output reg [63:0] Read_Data_Memory_S, Result_S,
    output reg [4:0] RD_S
);

    always @(negedge clk) 
    begin
        RegWrite_S = RegWrite;
        MemtoReg_S = MemtoReg;
        Read_Data_Memory_S = Read_Data_Memory;
        Result_S = Result;
        RD_S = RD;
    end
    
endmodule
