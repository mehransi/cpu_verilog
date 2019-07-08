module Memory(output reg signed[31:0] data1, data2, output [31:0] instruction,
input [31:0] address1, address2, instruction_address, write_data, ins_write_data, 
input reset, EN, clk, mem_write, counter, ins_mem_write, input [1:0] mem_read);

parameter n = 4194304;  // memory is like array[n][32];
reg [31:0] ram[0:n-1];

integer i;

assign instruction = (reset != 1) ? ((instruction_address >= n/2) ? ram[instruction_address]
 : 32'hFFFFFFFF) : 32'hFFFFFFFF;

/*
initial begin
	ram[n/2+5] = 32'b01001000000000000000000000000101;
	ram[n/2+6] = 32'b01001010100000000000000000000000;
	ram[n/2+7] = 32'b01001000010000000000000000000001;
	ram[n/2+8] = 32'b01001000100000000000000000000001;
	ram[n/2+9] = 32'b01001000110000000000000000000001;
	ram[n/2+10]= 32'b00001000000001100000000000000000;
	ram[n/2+11]= 32'b00001000000001100000000000000000;
	ram[n/2+12]= 32'b00000000010001000101000000000000;
	ram[n/2+13]= 32'b00000000100101001011000000000000;
	ram[n/2+14]= 32'b00000000100000100010000000000000;
	ram[n/2+15]= 32'b00000010110101000001000000000000;
	ram[n/2+16]= 32'b00000001010001000101000000000000;
	ram[n/2+17]= 32'b00001000000001100000000000000000;
	ram[n/2+18]= 32'b01011000001000000000000000010100;
	ram[n/2+19]= 32'b01111000001000000000000000001101;
	ram[n/2+20]= 32'b01010001010000000110000001100100;
	ram[n/2+21]= 32'b11111000000000000000000000000000;
end
*/
always @(posedge clk)
begin
	$display("0x00006064",ram[32'b00000000000000000110000001100100]);
	//$display("0x00000064",ram[32'b00000000000000000000000001100100]);
	if (reset) begin
		data1 <= 0;
		data2 <= 0;
		for (i = 0;i < n/2 + 5; i=i+1)
			ram[i] <= 0;
		ram[32'h00000004] <= 17;
		ram[32'h00000005] <= 3;
	end
	else if (!EN) begin
		data1 <= 32'bz;
		data2 <= 32'bz;
	end
	
	else if (mem_read == 1 && !mem_write) begin
		if (address1 < n/2) begin
			data1 <=  ram[address1];
		end
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

	if (ins_mem_write)
		ram[n/2 + counter] = ins_write_data;
	
end
endmodule
