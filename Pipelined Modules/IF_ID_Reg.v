`timescale 1ns / 1ps

module IF_ID_Reg(
    input flush,
    input clk, 
    input [63:0] PC,
    input [31:0] Instruction,
    
    output reg [63:0] PC_Stored,
    output reg [31:0] Instruction_Stored
   //output reg[63:0] tempPC,  output reg[31:0] tempIns
    );
//    reg[63:0] tempPC; reg[31:0] tempIns;
//    always @ (negedge clk)
//    begin
//        tempPC = PC;
//        tempIns = Instruction;
//    end
    
//    always @ (posedge clk) begin
//        PC_Stored = tempPC; Instruction_Stored = tempIns;
//    end
    always @ (posedge clk) begin 
        if (flush) begin PC_Stored = 0; Instruction_Stored = 0; end
        else begin PC_Stored = PC; Instruction_Stored = Instruction; end
    end
    
endmodule

