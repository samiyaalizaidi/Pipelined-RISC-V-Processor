`timescale 1ns / 1ps

module Forwarding_Unit(
    input EX_MEM_RegWrite,
    input [4:0]EX_MEM_RegisterRD,
    input [4:0]ID_EX_RegisterRS1,
    input [4:0]ID_EX_RegisterRS2,
    
    input MEM_WB_RegWrite,
    input [4:0]MEM_WB_RegisterRD,
    
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
    );
    
    always @ (EX_MEM_RegisterRD || MEM_WB_RegisterRD || EX_MEM_RegWrite || MEM_WB_RegWrite || ID_EX_RegisterRS1 || ID_EX_RegisterRS2)
    begin
        // EX Hazards
        if ((EX_MEM_RegWrite) & (EX_MEM_RegisterRD) & (EX_MEM_RegisterRD == ID_EX_RegisterRS1))
        begin
            assign ForwardA = 2'b10;
            assign ForwardB = 2'b00;
        end
        
        else if((EX_MEM_RegWrite) & (!EX_MEM_RegisterRD) & (EX_MEM_RegisterRD == ID_EX_RegisterRS2))
        begin
            assign ForwardA = 2'b00;
            assign ForwardB = 2'b10;
        end
        
        // MEM Hazard
        else if ((MEM_WB_RegWrite) & (MEM_WB_RegisterRD) & (MEM_WB_RegisterRD == ID_EX_RegisterRS1))
        begin
            assign ForwardA = 2'b01;
            assign ForwardB = 2'b00;
        end
        
        else if ((MEM_WB_RegWrite) & (MEM_WB_RegisterRD) & (MEM_WB_RegisterRD == ID_EX_RegisterRS2))
        begin
            assign ForwardA = 2'b00;
            assign ForwardB = 2'b01;
        end
    end
    
endmodule