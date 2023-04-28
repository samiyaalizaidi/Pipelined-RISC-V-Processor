`timescale 1ns / 1ps

module Mux3(input [63:0] a,
	input [63:0] b,
	input [63:0] c,
	input  [1:0] sel,
		
	output reg [63:0]data_out
    );
     always @ (*)
    begin
        if (sel == 2'b00)
            data_out = a;
        else if (sel == 2'b01)
            data_out = b;
        else
            data_out = c;
    end

endmodule
