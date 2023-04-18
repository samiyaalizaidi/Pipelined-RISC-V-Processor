module Control_Unit
(
	input [6:0] Opcode,
	output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump,
	output reg [1:0] ALUOp
);

	always @ (Opcode)
	begin
		case (Opcode)
			7'b0110011: // R type
				begin
				  Jump = 0;
					Branch = 0;
					MemRead = 0;
					MemtoReg = 0;
					MemWrite = 0;
					ALUSrc = 0;
					RegWrite = 1;
					ALUOp = 2'b10;
				end
			
			7'b0000011: // ld 
				begin
				  Jump = 0;
					Branch = 0;
					MemRead = 1;
					MemtoReg = 1;
					MemWrite = 0;
					ALUSrc = 1;
					RegWrite = 1;
					ALUOp = 2'b00;
				end
			7'b0010011: // addi and slli
				begin
				    Jump = 0;
					Branch = 0;
					MemRead = 0;
					MemtoReg = 0;
					MemWrite = 0;
					ALUSrc = 1;
					RegWrite = 1;
					ALUOp = 2'b11;
				end
			7'b0100011: // SD
				begin
				   Jump = 0;
					Branch = 0;
					MemRead = 0;
					MemtoReg = 1'bx;
					MemWrite = 1;
					ALUSrc = 1;
					RegWrite = 0;
					ALUOp = 2'b00;
				end
			7'b1100011:  //SB
				begin
				    Jump = 0;
					Branch = 1;
					MemRead = 0;
					MemtoReg = 1'bx;
					MemWrite = 0;
					ALUSrc = 0;
					RegWrite = 0;
					ALUOp = 2'b01;
				end
				
			7'b1100111: // jalr
			begin
			    Jump = 1;
			    Branch = 0;
                MemRead = 1'bx;
                MemtoReg = 1;
                MemWrite = 1'bx;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b00;
			end
			
			7'b1101111: // jal
			begin
			    Jump = 1;
			    Branch = 0;
                MemRead = 1'bx;
                MemtoReg = 1;
                MemWrite = 1'bx;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b00;
			end
			default:
			 begin
			    Jump = 1'bx;
			    Branch = 1'bx;
                MemRead = 1'bx;
                MemtoReg = 1'bx;
                MemWrite = 1'bx;
                ALUSrc = 1'bx;
                RegWrite = 1'bx;
                ALUOp = 2'bx;
			 end
			 
		endcase
	end

endmodule 
