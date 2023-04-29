`timescale 1ns / 1ps

module hazard_detection_unit (
    input ID_EX_MemRead,
    input ID_EX_RegRD,
    input IF_ID_RegRS1,
    input IF_ID_RegRS2,
    output reg Hazard
);

always @(*) begin
    if (ID_EX_MemRead && ((ID_EX_RegRD == IF_ID_RegRS1) || (ID_EX_RegRD == IF_ID_RegRS2)))
        Hazard = 1;
    else
        Hazard = 0;    
end

endmodule
