`timescale 1ns / 1ps

module testbench();
    reg clk; reg reset;
    wire [63:0] PC_Out; wire [31:0] instruction; wire [4:0] rs1;
    wire [4:0] rs2; wire [4:0] rd; wire [63:0] WriteData; wire [63:0] ReadData1;
    wire [63:0] ReadData2; wire [63:0] imm_data; 
    wire [63:0] mux1Out; wire [63:0] Result; wire [63:0]  Read_Data_Memory; wire [6:0] opcode; 
    
    RISC_V_Processor p(clk, reset, PC_Out, instruction, rs1, rs2, rd, WriteData, ReadData1, ReadData2, imm_data, mux1Out, Result, Read_Data_Memory, opcode);
    
    initial begin
        clk = 0;
        reset = 0;
    end
    
    always 
    #10 clk = ~clk;
endmodule
