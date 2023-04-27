`timescale 1ns / 1ps
module ALU_64_bit
(
	input [63:0]a, b,
	input [3:0] ALUOp,
	
	output reg [63:0] Result,
	output reg ZERO
);

wire BLT = 4'b1000; 

always @ (*)
begin
	case (ALUOp)
		4'b0000: Result = a & b; // AND
		4'b0001: Result = a | b; // OR
		4'b0010: Result = a + b; // ADD
		4'b0110: Result = a - b; // SUB
		4'b1100: Result = ~(a | b); // NOR
		4'b1000: Result = a < b; // BLT
		4'b1001: Result =  a + b; // ADDI
		4'b1111: Result = a * (2'd2**b); // SLLI
		default: Result = 0;
	endcase
	
	if (ALUOp == BLT & Result) ZERO = 1;
	else ZERO = (Result == 0);
end

endmodule 
