`timescale 1ns / 1ps
module cpu_tb;
reg clk, rst, enable;
wire signed [31:0] alu_result;
wire [31:0] pc, ir, rin, rout;
wire [7:0] flags;

CPU uut(clk , rst, enable, alu_result, pc, ir, flags);

always 
	#1 clk = ~clk;

initial begin
	clk = 0;
	rst = 1;
	enable = 1;
	#5 rst = 0;
	
end

endmodule

