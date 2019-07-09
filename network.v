`timescale 1ns / 1ps
module network;
reg clk, rst, enable;
reg c1 = 1, c2 = 1, c3 = 1, c4 = 1, c5 = 1, c6 = 1, c7 = 1, c8 = 1, c9 = 1;  //counter of instructions for ins memory
reg imw1 = 0, imw2 = 0, imw3 = 0, imw4 = 0, imw5 = 0, imw6 = 0, imw7 = 0, imw8 = 0, imw9 = 0; //ins_mem_write

reg [31:0] itw1, itw2, itw3, itw4, itw5, itw6, itw7, itw8, itw9; //instruction_to_write

//output ports
wire signed [31:0] o_p1, o_p2, o_p3, o_p4, o_p5, o_p6, o_p7, o_p8, o_p9;

//alu results
wire signed [31:0] ar1, ar2, ar3, ar4, ar5, ar6, ar7, ar8, ar9;
wire [31:0] pc1, ir1, pc2, ir2, pc3, ir3, pc4, ir4, pc5, ir5, pc6, ir6, pc7, ir7, pc8, ir8, pc9, ir9;

//flags
wire [7:0] flags1, flags2, flags3, flags4, flags5
, flags6, flags7, flags8, flags9;


//output of routers
wire [63:0] out_left1,out_right1,out_up1,out_down1,iout_left2,out_right2,out_up2,out_down2,out_left3,out_right3,out_up3,out_down3,
 out_left4,out_right4,out_up4,out_down4,out_left5,out_right5,out_up5,out_down5,out_left6,out_right6,out_up6,out_down6,
 out_left7,out_right7,out_up7,out_down7,out_left8,out_right8,out_up8,out_down8,out_left9,out_right9,out_up9,out_down9;

//router to cpu
wire signed [31:0] to_cpu1,to_cpu2,to_cpu3,to_cpu4,to_cpu5,to_cpu6,to_cpu7,to_cpu8,to_cpu9;

// router flag set
wire set_fi1 ,set_fi2,set_fi3 ,set_fi4,set_fi5,set_fi6,set_fi7,set_fi8,set_fi9;
wire [63:0] freenet = 0;

CPU p1(clk , rst, enable, c1, imw1, to_cpu1,itw1, ar1,o_p1, pc1, ir1, flags1);
CPU p2(clk , rst, enable, c2, imw2, to_cpu2,itw2, ar2,o_p2, pc2, ir2, flags2);
CPU p3(clk , rst, enable, c3, imw3, to_cpu3,itw3, ar3,o_p3, pc3, ir3, flags3);
CPU p4(clk , rst, enable, c4, imw4, to_cpu4,itw4, ar4,o_p4, pc4, ir4, flags4);
CPU p5(clk , rst, enable, c5, imw5, to_cpu5,itw5, ar5,o_p5, pc5, ir5, flags5);
CPU p6(clk , rst, enable, c6, imw6, to_cpu6,itw6, ar6,o_p6, pc6, ir6, flags6);
CPU p7(clk , rst, enable, c7, imw7, to_cpu7,itw7, ar7,o_p7, pc7, ir7, flags7);
CPU p8(clk , rst, enable, c8, imw8, to_cpu8,itw8, ar8,o_p8, pc8, ir8, flags8);
CPU p9(clk , rst, enable, c9, imw9, to_cpu9,itw9, ar9,o_p9, pc9, ir9, flags9);

Router r1(freenet,out_left1,freenet,out_up4,o_p1,16'h0003 , 16'h0003,out_left1,out_right1,out_up1,out_down1,to_cpu1,set_fi1);
Router r2(out_right1,out_left3,freenet,out_up5,o_p2,16'h0003 , 16'h0003,out_left2,out_right2,out_up2,out_down2,to_cpu2,set_fi2);
Router r3(out_right2,freenet,freenet,out_up6,o_p3,16'h0003 , 16'h0003,out_left3,out_right3,out_up3,out_down3,to_cpu3,set_fi3);

Router r4(freenet,out_left5,out_down1,out_up7,o_p4,16'h0003 , 16'h0003,out_left4,out_right4,out_up4,out_down4,to_cpu4,set_fi4);
Router r5(out_right4,out_left6,out_down2,out_up8,o_p5,16'h0003 , 16'h0003,out_left5,out_right5,out_up5,out_down5,to_cpu5,set_fi5);
Router r6(out_right5,freenet,out_down3,out_up9,o_p6,16'h0003 , 16'h0003,out_left6,out_right6,out_up6,out_down6,to_cpu6,set_fi6);

Router r7(freenet,out_left8,out_down4,freenet,o_p7,16'h0003 , 16'h0003,out_left7,out_right7,out_up7,out_down7,to_cpu7,set_fi7);
Router r8(out_right7,out_left9,out_down5,freenet,o_p8,16'h0003 , 16'h0003,out_left8,out_right8,out_up8,out_down8,to_cpu8,set_fi8);
Router r9(out_right8,freenet,out_down6,freenet,o_p9,16'h0003 , 16'h0003,out_left9,out_right9,out_up9,out_down9,to_cpu9,set_fi9);
defparam r1.x = 1, r1.y = 1, r2.x = 2, r2.y = 1, r3.x = 3, r3.x = 1, r4.x = 1, r4.y = 2, r5.x = 2, r5.y = 2, r6.x = 3, r6.y = 2,
r7.x = 1, r7.y = 3, r8.x = 2, r8.y = 3, r9.x = 3, r9.y = 3;


always 
	#1 clk = ~clk;

initial begin
	clk = 0;
	rst = 1;
	enable = 1;
	#10 itw1 = 32'b01001010100000000000000000000000;
	 itw2 = 32'b01001010100000000000000000000000;
	 itw3 = 32'b01001010100000000000000000000000;
	 itw4 = 32'b01001010100000000000000000000000;
	 itw5 = 32'b01001000010000000000000000000001;
	 itw6 = 32'b01001000010000000000000000000001;
	#450 rst = 0;
	#900 $finish;
	
end

endmodule
