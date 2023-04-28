`timescale 1ns / 1ps

module testbench_pipeline();
    reg clk; reg reset;// wire [63:0] tempPC; wire [31:0] tempIns;
    RISC_V_Pipelined p(clk, reset);//, tempPC, tempIns);
    
    initial begin
        clk = 0;
        reset = 0;
    end
    
    always 
    #10 clk = ~clk;
endmodule