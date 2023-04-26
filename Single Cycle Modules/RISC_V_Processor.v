`timescale 1ns / 1ps

module RISC_V_Processor(
    input clk, reset,
    output [63:0] PC_Out, output [31:0] instruction, output [4:0] rs1,
    output [4:0] rs2, output [4:0] rd, output [63:0] Write_Data, output [63:0] ReadData1, 
    output [63:0] ReadData2, output [63:0] imm_data, 
    output [63:0] mux1Out, output [63:0] Result, output [63:0] Read_Data_Memory, output [6:0] opcode
    );
    
    wire [63:0] PC_In0; 
    wire [63:0] PC_In1;
    wire [2:0] funct3;
    wire [6:0] funct7;

    
    // for control signals
    wire Branch; wire MemRead; wire MemtoReg; wire MemWrite; wire ALUSrc; 
    wire RegWrite; 
    wire [1:0] ALUOp;

    // for the register file
    wire [63:0] ReadData1; wire [63:0] ReadData2;
    wire [63:0] PC_In;
    wire [3:0] Operation;
		
    Program_Counter PC(clk, reset, PC_In, PC_Out);
    Adder add4(PC_Out, 64'd4, PC_In0);
    
    // INSTRUCTION READING
    Instruction_Memory IMem(PC_Out, instruction);
    InsParser IP(instruction, opcode, rd, funct3, rs1, rs2, funct7);
    ImmGen DataExtractor(instruction, imm_data);
    
    // CONTROL UNIT
    Control_Unit CU(opcode, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
    
    // REGSISTERS READING
    registerFile Registers(Write_Data, rs1, rs2, rd, RegWrite, clk, reset, ReadData1, ReadData2);
    Mux mux1(ReadData2, imm_data, ALUSrc, mux1Out); 
    
    // CALCULATE
    ALU_Control alu_control(ALUOp, {instruction[30], instruction[14:12]}, Operation);
    ALU_64_bit alu(ReadData1, mux1Out, Operation, Result, ZERO);
    
    // DATA MEMORY
    Data_Memory data(Result, ReadData2, clk, MemWrite, MemRead, Read_Data_Memory);
    Mux mux2(Result, Read_Data_Memory, MemtoReg, Write_Data);
    
    // BRANCHING
    Adder add_beq(PC_Out, imm_data * 2'd2, PC_In1);
    Mux mux3(PC_In0, PC_In1, Branch & ZERO, PC_In); 
    
    
endmodule
