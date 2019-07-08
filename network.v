`timescale 1ns / 1ps
module network;
reg clk, rst, enable;
reg c1, c2, c3, c4, c5, c6, c7, c8, c9;  //counter of instructions for ins memory
reg imw1, imw2, imw3, imw4, imw5, imw6, imw7, imw8, imw9; //ins_mem_write
//input ports
reg signed [31:0] in_p1, in_p2, in_p3, in_p4, in_p5, in_p6, in_p7, in_p8, in_p9;
reg [31:0] itw1, itw2, itw3, itw4, itw5, itw6, itw7, itw8, itw9; //instruction_to_write
//output ports
wire signed [31:0] o_p1, o_p2, o_p3, o_p4, o_p5, o_p6, o_p7, o_p8, o_p9;
//alu results
wire signed [31:0] ar1, ar2, ar3, ar4, ar5, ar6, ar7, ar8, ar9;
wire [31:0] pc, ir, rin, rout;
//flags
wire [7:0] flags1, flags2, flags3, flags4, flags5, flags6, flags7, flags8, flags9;

CPU p1(clk , rst, enable, c1, imw1, in_p1,itw1, ar1,o_p1, pc1, ir1, flags1);

always 
	#86 clk = ~clk;

initial begin
	clk = 0;
	rst = 1;
	enable = 1;
	#450 rst = 0;
	
end

endmodule

