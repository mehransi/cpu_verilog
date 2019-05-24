module Control(input [4:0] opcode, input reset, output reg rwr, ma1,
 op1, mem_write, reg_write, rFI, rFO, sFO, ION, IOF,
 output reg [1:0] pc_selector, rwd, mem_read, op2, output reg[2:0] ALUOp);

always @(opcode, reset) begin
	if (reset == 1'b1) begin
		rwr = 0;
		rwd = 0;
		reg_write = 0;
		mem_read = 0;  //data_mem_read
		mem_write = 0;
		pc_selector = 0;
		ALUOp = 0;
		ma1 = 0;
		op1 = 0;
		op2 = 0;
		rFI = 1;
		sFO = 0;
		rFO = 1;
		ION = 1;
		IOF = 0;
	end 
	else begin
	case(opcode)

		5'b00000:begin  //add
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b00001:begin  //sub
		ALUOp = 1; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b00010:begin  //mul
		ALUOp = 2; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b00011:begin  //div
		ALUOp = 3; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b00100:begin  //and
		ALUOp = 4; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b00101:begin  //or
		ALUOp = 5; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b00110:begin  //xor
		ALUOp = 6; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b00111:begin  //sort
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b10000:begin  //addi
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 2; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 1; op2 = 1; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b10001:begin  //subi
		ALUOp = 1; rwr = 0; rwd = 0; ma1 = 0; mem_read = 2; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 1; op2 = 1; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b10010:begin  //muli
		ALUOp = 2; rwr = 0; rwd = 0; ma1 = 0; mem_read = 2; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 1; op2 = 1; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b10011:begin  //divi
		ALUOp = 3; rwr = 0; rwd = 0; ma1 = 0; mem_read = 2; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 1; op2 = 1; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b10100:begin  //remi
		ALUOp = 7; rwr = 0; rwd = 0; ma1 = 0; mem_read = 2; mem_write = 0;
		reg_write = 1; op1 = 1; op2 = 1; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b10101:begin  //andi
		ALUOp = 4; rwr = 0; rwd = 0; ma1 = 0; mem_read = 2; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 1; op2 = 1; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b10110:begin  //ori
		ALUOp = 5; rwr = 0; rwd = 0; ma1 = 0; mem_read = 2; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 1; op2 = 1; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b10111:begin  //xori
		ALUOp = 6; rwr = 0; rwd = 0; ma1 = 0; mem_read = 2; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 1; op2 = 1; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b01000:begin  //ld
		ALUOp = 0; rwr = 1; rwd = 2; ma1 = 1; mem_read = 1; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b01001:begin  //ldi
		ALUOp = 0; rwr = 1; rwd = 1; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b01010:begin  //st
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 1; mem_read = 0; mem_write = 1; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b01011:begin  //jz
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 1; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b01100:begin  //jp
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 1; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b01101:begin  //jinc
		ALUOp = 0; rwr = 1; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 2; pc_selector = 2; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b01110:begin  //jdec
		ALUOp = 1; rwr = 1; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 1; op1 = 0; op2 = 3; pc_selector = 2; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b01111:begin  //jump
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 1; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b11000:begin  //IN
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b11001:begin  //OUT
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b11010:begin  //resetFI
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 1; rFO = 0; ION = 0; IOF = 0;
		end

		5'b11011:begin  //setFO
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 1;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		5'b11100:begin  //resetFO
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 1; ION = 0; IOF = 0;
		end

		5'b11101:begin  //ION
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 1; IOF = 0;
		end

		5'b11110:begin  //IOF
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 1;
		end

		5'b11111:begin  //HLT
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end

		default:begin 
		ALUOp = 0; rwr = 0; rwd = 0; ma1 = 0; mem_read = 0; mem_write = 0; sFO = 0;
		reg_write = 0; op1 = 0; op2 = 0; pc_selector = 0; rFI = 0; rFO = 0; ION = 0; IOF = 0;
		end


	endcase
	end
end
endmodule
