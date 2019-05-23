module ALU(output reg [31:0] result, output V,C,Z,S,
input [31:0] a, b, input [2:0] ALUOp);

assign Z = (result == 0)? 1 : 0;
assign S = result[31];
assign {carry , sum} = a + b;
assign {borrow, sub} = a - b;
assign V = ((ALUOp == 0) && (a[31] == b[31] && a[31] != result[31])) || 
	   ((ALUOp == 1) && (a[31] != b[31] && a[31] != result[31]));
assign C = (ALUOp == 0 || ALUOp == 1) && (carry || borrow);
always @(*) begin
	case (ALUOp)
		3'd0: result <= sum;
		3'd1: result <= sub;
		3'd2: result <= a * b;
		3'd3: result <= a / b;
		3'd4: result <= a & b;
		3'd5: result <= a | b;
		3'd6: result <= a ^ b;
		3'd7: result <= a % b;
	endcase
end

endmodule
