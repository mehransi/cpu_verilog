module Memory(output reg signed[31:0] data1, data2, output [31:0] instruction,
input [31:0] address1, address2, instruction_address, write_data, input reset, EN, clk, mem_write, mem_read);

parameter n = 2097152;  // memory is like array[n][32];
reg [31:0] ram[0:n-1];

integer i;

assign instruction = (reset != 1) ? ((instruction_address >= n/2) ? ram[instruction_address] : 0) : 0;
always @(posedge clk)
begin
	if (reset) begin
		data1 <= 0;
		data2 <= 0;
		for (i = 0;i < n; i=i+1)
			ram[i] <= 0;
	end
	
	else if (!EN) begin
		data1 <= 32'bz;
		data2 <= 32'bz;
	end
	
	else if (mem_read == 1 && !mem_write) begin
		if (address1 < n/2)
			data1 <=  ram[address1];
		else
			data1 <= 0;
	end
	
	else if (mem_read == 2 && !mem_write) begin
		if (address1 < n/2 && address2 < n/2) begin
			data1 <= ram[address1];
			data2 <= ram[address2];
		end
		else begin
			data1 <= 0;
			data2 <= 0;
		end
	end
	
	else if (mem_read == 0 && mem_write) begin
		if (address1 < n/2)
			ram[address1] <= write_data;
	end
	
end
endmodule
