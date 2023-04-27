`timescale 1ns / 1ps

module RISC_V_Pipelined(
    input clk, 
    input reset
);
    
 /** IF Stage Wires and Modules **/

wire [63:0] PC_Normal, PC_Branch, PC_In, PC_Out;  // for the PC
wire sel_pc; // for the PC Mux
wire [31:0] Instruction_IF_ID; // Stored in pipeline reg

wire [63:0] Instruction_IF_ID_Out, PC_IF_ID_Out; 

Mux PC_Mux(PC_Normal, PC_Branch, sel_pc, PC_In); // get the PC value
Program_Counter PC(clk, reset, PC_In, PC_Out); // pass through PC
Instruction_Memory IMem(PC_Out, Instruction_IF_ID); // fetch instruction
Adder PC_Add_4(PC_Out, 64'd4, PC_Normal); // PC + 4 = PC_Normal 
IF_ID_Reg IF_ID(clk, PC_Out, Instruction_IF_ID, PC_IF_ID_Out, Instruction_IF_ID_Out); // pipeline register

/** ID Stage Wires and Modules **/

// use the IF/ID outputs in this stage
wire [6:0] opcode, funct7;
wire [4:0] rs1, rs2, rd;
wire [2:0] funct3;
wire [63:0] imm_val, Write_Data_Reg_from_WB, ReadData1, ReadData2;
// Note: all the writing inputs come from the Mem/WB
// control signals 
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite; 
wire [1:0] ALUOp;
wire [4:0] rd_MEM_WB_Mux_Out; wire RegWrite_MEM_WB_Out; // from mem wb

InsParser I_Parser(Instruction_IF_ID_Out, opcode, rd, funct3, rs1, rs2, funct7); // decode the instruction 
ImmGen getImmValue(Instruction_IF_ID_Out, imm_val); // 64 bits immediate value
Control_Unit Control(opcode, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp); // obtain the control signals
registerFile Registers(Write_Data_Reg_from_WB, rs1, rs2, rd_MEM_WB_Mux_Out, RegWrite_MEM_WB_Out, clk, reset, ReadData1, ReadData2); // depends on MEM/WB as well

// ID/EX Pipeline Register's Outputs
wire [63:0] PC_ID_EX_Out, ReadData1_ID_EX_Out, ReadData2_ID_EX_Out, imm_value_ID_EX_Out;
wire [3:0] funct_ID_EX_Out; wire [4:0] rd_ID_EX_Out;
wire MemtoReg_ID_EX_Out, RegWrite_ID_EX_Out, Branch_ID_EX_Out, MemWrite_ID_EX_Out, MemRead_ID_EX_Out, ALUSrc_ID_EX_Out;
wire [1:0] ALUOp_ID_EX_Out;

ID_EX_Reg ID_EX(clk, PC_IF_ID_Out, ReadData1, ReadData2, imm_val, {Instruction_IF_ID_Out[30] ,funct3},
                rd, MemtoReg, RegWrite, Branch, MemWrite, MemRead, ALUSrc, ALUOp,
                PC_ID_EX_Out, ReadData1_ID_EX_Out, ReadData2_ID_EX_Out, imm_value_ID_EX_Out, funct_ID_EX_Out, rd_ID_EX_Out,
                MemtoReg_ID_EX_Out, RegWrite_ID_EX_Out, Branch_ID_EX_Out, MemWrite_ID_EX_Out, MemRead_ID_EX_Out, ALUSrc_ID_EX_Out,
                ALUOp_ID_EX_Out);
                
/** EX Stage Wires and Modules **/
wire [63:0] Mux_Out; // from the mux to ALU input 2
wire [3:0] Operation;
wire [63:0] Result; wire ZERO;

Mux ALU_MUX(ReadData2_ID_EX_Out, imm_value_ID_EX_Out, ALUSrc, Mux_Out); // Selects rs2 and imm
ALU_Control aluControl(ALUOp_ID_EX_Out, funct_ID_EX_Out, Operation); // returns operation 
ALU_64_bit ALU(ReadData1_ID_EX_Out, Mux_Out, Operation, Result, ZERO); // execute
Adder branchAdd(PC_ID_EX_Out, imm_value_ID_EX_Out * 2'd2, PC_temp_branch); // calculates branch address

// EX/MEM Pipeline Registers
wire RegWrite_EX_MEM_Out, MemWrite_EX_MEM_Out, Branch_EX_MEM_Out, ZERO_EX_MEM_Out, MemtoReg_EX_MEM_Out, MemRead_EX_MEM_Out;
wire [63:0] Result_EX_MEM_Out, Write_Data_Mem_EX_MEM_Out, PC_EX_MEM_Out;
wire [3:0] funct_EX_MEM_Out; wire [4:0] rd_EX_MEM_Out;

EX_MEM_Reg EX_MEM(clk, PC_ID_EX_Out, RegWrite_ID_EX_Out, MemWrite_ID_EX_Out, Branch_ID_EX_Out, ZERO, MemtoReg_ID_EX_Out, MemRead_ID_EX_Out,
                  Result, ReadData2, PC_temp_branch, funct_ID_EX_Out, rd_ID_EX_Out,
                  PC_EX_MEM_Out, RegWrite_EX_MEM_Out, MemWrite_EX_MEM_Out, Branch_EX_MEM_Out, ZERO_EX_MEM_Out, MemtoReg_EX_MEM_Out, MemRead_EX_MEM_Out,
                  Result_EX_MEM_Out, Write_Data_Mem_EX_MEM_Out, PC_Branch, funct_EX_MEM_Out, rd_EX_MEM_Out);
                  
/** MEM Stage Wires and Modules**/

wire [63:0] ReadData_Mem; // data memory output
assign sel_pc = Branch_EX_MEM_Out & ZERO_EX_MEM_Out; // and gate for branching

Data_Memory dataMem(Result_EX_MEM_Out, Write_Data_Mem_EX_MEM_Out, clk, MemWrite_EX_MEM_Out, MemRead_EX_MEM_Out, ReadData_Mem); // access the main memory

// few MEM_WB outputs are already declared in the ID stage
wire MemtoReg_MEM_WB_Out;
wire [63:0] ReadDataMem_MEM_WB_Out, Result_MEM_WB_Out;


MEM_WB_Reg MEM_WB(clk, RegWrite_EX_MEM_Out, MemtoReg_EX_MEM_Out, ReadData_Mem, Result_EX_MEM_Out, rd_EX_MEM_Out,
                  RegWrite_MEM_WB_Out, MemtoReg_MEM_WB_Out, ReadDataMem_MEM_WB_Out, Result_MEM_WB_Out, 
                  rd_MEM_WB_Mux_Out);
                  
/** WB Stage **/
                 
Mux rd_Mux(Result_MEM_WB_Out, ReadDataMem_MEM_WB_Out, MemtoReg_MEM_WB_Out, Write_Data_Reg_from_WB); // returns the data to be written on the reg file

endmodule
