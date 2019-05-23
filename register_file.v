module RegisterFile(output signed [31:0] data1, data2, input [4:0] reg1, reg2,
write_reg, input signed [31:0] write_data, input reg_write, clk, rst);

reg [31:0] registers[0:31];

assign data1 = registers[reg1];
assign data2 = registers[reg2];

integer i;
always @(posedge clk) begin
	if (rst) begin
		for (i=0;i<32;i=i+1) begin
			registers[i] <= 0;
		end
	end

	else if (reg_write)
		registers[write_reg] <= write_data;
end

endmodule
