`timescale 1ns / 1ps

module ALU_Control
(
	input [1:0] ALUOp, 
	input [3:0] Funct,
	output reg [3:0] Operation
);

	always @ (*)
	begin
		case(ALUOp)
			2'b00: begin // for ld, sd, addi, slli
			case(Funct[2:0])
                3'b000: Operation = 4'b1001; // addi
                3'b001: Operation = 4'b1111; // slli
                default: Operation = 4'b0010; 
            endcase 
            end
            
			2'b01: // BRANCH
			begin
			case(Funct[2:0])
				3'b000: Operation = 4'b0110;
				3'b100: Operation = 4'b1000; // blt
			endcase end

			2'b10: // R-FORMAT
			begin 
			case(Funct)
				4'b0000: Operation = 4'b0010;
				4'b1000: Operation = 4'b0110;
				4'b0111: Operation = 4'b0000;
				4'b0110: Operation = 4'b0001;
			endcase
			end
		endcase
	end
	
endmodule

