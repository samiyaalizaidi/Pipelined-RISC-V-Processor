`timescale 1ns / 1ps

module Mux
(
	input [63:0] a,
	input [63:0] b,
	input  sel,
	
	output reg [63:0]data_out
);

    always @ (*)
    begin
        if (!sel)
            data_out = a;
        else
            data_out = b;
    end

endmodule

