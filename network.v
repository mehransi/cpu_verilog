`timescale 1ns / 1ps
module network;
reg clk, rst, enable;
reg c1 = 1, c2 = 1, c3 = 1, c4 = 1, c5 = 1, c6 = 1, c7 = 1, c8 = 1, c9 = 1;  //counter of instructions for ins memory
reg imw1 = 1, imw2 = 1, imw3 = 1, imw4 = 1, imw5 = 1, imw6 = 1, imw7 = 1, imw8 = 1, imw9 = 1; //ins_mem_write



//input ports
reg signed [31:0] in_p1, in_p2, in_p3, in_p4, in_p5, in_p6, in_p7, in_p8, in_p9;
reg [31:0] itw1, itw2, itw3, itw4, itw5, itw6, itw7, itw8, itw9; //instruction_to_write



//output ports
wire signed [31:0] o_p1, o_p2, o_p3, o_p4, o_p5, o_p6, o_p7, o_p8, o_p9;

//alu results
wire signed [31:0] ar1, ar2, ar3, ar4, ar5, ar6, ar7, ar8, ar9;
wire [31:0] pc, ir, rin, rout;

//flags
wire [7:0] flags1 = 8'b00000000, flags2 = 8'b00000000, flags3 = 8'b00000000, flags4 = 8'b00000000, flags5 = 8'b00000000
, flags6 = 8'b00000000, flags7 = 8'b00000000, flags8 = 8'b00000000, flags9 = 8'b00000000;

//input of routers
reg [63:0] in_left1,in_right1,in_up1,in_down1,in_left2,in_right2,in_up2,in_down2,in_left3,in_right3,in_up3,in_down3,
 in_left4,in_right4,in_up4,in_down4,in_left5,in_right5,in_up5,in_down5,in_left6,in_right6,in_up6,in_down6,
 in_left7,in_right7,in_up7,in_down7,in_left8,in_right8,in_up8,in_down8,in_left9,in_right9,in_up9,in_down9;

//output of routers
wire [63:0] out_left1,out_right1,out_up1,out_down1,out_left2,out_right2,out_up2,out_down2,out_left3,out_right3,out_up3,out_down3,
 out_left4,out_right4,out_up4,out_down4,out_left5,out_right5,out_up5,out_down5,out_left6,out_right6,out_up6,out_down6,
 out_left7,out_right7,out_up7,out_down7,out_left8,out_right8,out_up8,out_down8,out_left9,out_right9,out_up9,out_down9;

//from cpu to router
reg [31:0] from_cpu1,from_cpu2,from_cpu3,from_cpu4,from_cpu5,from_cpu6,from_cpu7,from_cpu8,from_cpu9;

//router to cpu
wire [31:0] to_cpu1,to_cpu2,to_cpu3,to_cpu4,to_cpu5,to_cpu6,to_cpu7,to_cpu8,to_cpu9;

// router flag set
wire set_fi1 = 1,set_fi2 = 1,set_fi3 = 1,set_fi4 = 1,set_fi5 = 1,set_fi6 = 1,set_fi7 = 1,set_fi8 = 1,set_fi9 = 1;

//wires between routers
wire [63:0] RRwire1_2, RRwire1_4, RRwire2_1, RRwire2_3, RRwire2_5, RRwire3_2, RRwire3_6, RRwire4_1, RRwire4_5, RRwire4_7, RRwire5_2, RRwire5_4, RRwire5_6, RRwire5_8,
 RRwire6_3, RRwire6_5, RRwire6_9, RRwire7_4, RRwire7_8, RRwire8_5, RRwire8_7, RRwire8_9, RRwire9_6, RRwire9_8;

//wires between a single router and cpu
wire [31:0] RCwire1_1, CRwire1_1, RCwire2_2, CRwire2_2, RCwire3_3, CRwire3_3, RCwire4_4, CRwire4_4, RCwire5_5, CRwire5_5,
 RCwire6_6, CRwire6_6, RCwire7_7, CRwire7_7, RCwire8_8, CRwire8_8, RCwire9_9, CRwire9_9;

CPU p1(clk , rst, enable, c1, imw1, in_p1,itw1, ar1,o_p1, pc1, ir1, flags1);
CPU p2(clk , rst, enable, c2, imw2, in_p2,itw2, ar2,o_p2, pc2, ir2, flags2);
CPU p3(clk , rst, enable, c3, imw3, in_p3,itw3, ar3,o_p3, pc3, ir3, flags3);
CPU p4(clk , rst, enable, c4, imw4, in_p4,itw4, ar4,o_p4, pc4, ir4, flags4);
CPU p5(clk , rst, enable, c5, imw5, in_p5,itw5, ar5,o_p5, pc5, ir5, flags5);
CPU p6(clk , rst, enable, c6, imw6, in_p6,itw6, ar6,o_p6, pc6, ir6, flags6);
CPU p7(clk , rst, enable, c7, imw7, in_p7,itw7, ar7,o_p7, pc7, ir7, flags7);
CPU p8(clk , rst, enable, c8, imw8, in_p8,itw8, ar8,o_p8, pc8, ir8, flags8);
CPU p9(clk , rst, enable, c9, imw9, in_p9,itw9, ar9,o_p9, pc9, ir9, flags9);

Router r1(16'h0001,16'h0001,64'h0003000300030003,in_right1,in_up1,in_down1,from_cpu1,16'h0003 , 16'h0003,out_left1,out_right1,out_up1,out_down1,to_cpu1,set_fi1);
Router r2(16'h0002,16'h0001,in_left2,in_right2,in_up2,in_down2,from_cpu2,16'h0003 , 16'h0003,out_left2,out_right2,out_up2,out_down2,to_cpu2,set_fi2);
Router r3(16'h0003,16'h0001,in_left3,in_right3,in_up3,in_down3,from_cpu3,16'h0003 , 16'h0003,out_left3,out_right3,out_up3,out_down3,to_cpu3,set_fi3);
Router r4(16'h0001,16'h0002,in_left4,in_right4,in_up4,in_down4,from_cpu4,16'h0003 , 16'h0003,out_left4,out_right4,out_up4,out_down4,to_cpu4,set_fi4);
Router r5(16'h0002,16'h0002,in_left5,in_right5,in_up5,in_down5,from_cpu5,16'h0003 , 16'h0003,out_left5,out_right5,out_up5,out_down5,to_cpu5,set_fi5);
Router r6(16'h0003,16'h0002,in_left6,in_right6,in_up6,in_down6,from_cpu6,16'h0003 , 16'h0003,out_left6,out_right6,out_up6,out_down6,to_cpu6,set_fi6);
Router r7(16'h0001,16'h0003,in_left7,in_right7,in_up7,in_down7,from_cpu7,16'h0003 , 16'h0003,out_left7,out_right7,out_up7,out_down7,to_cpu7,set_fi7);
Router r8(16'h0002,16'h0003,in_left8,in_right8,in_up8,in_down8,from_cpu8,16'h0003 , 16'h0003,out_left8,out_right8,out_up8,out_down8,to_cpu8,set_fi8);
Router r9(16'h0003,16'h0003,in_left9,in_right9,in_up9,in_down9,from_cpu9,16'h0003 , 16'h0003,out_left9,out_right9,out_up9,out_down9,to_cpu9,set_fi9);

assign RCwire1_1 = to_cpu1;
assign RCwire2_2 = to_cpu2;
assign RCwire3_3 = to_cpu3;
assign RCwire4_4 = to_cpu4;
assign RCwire5_5 = to_cpu5;
assign RCwire6_6 = to_cpu6;
assign RCwire7_7 = to_cpu7;
assign RCwire8_8 = to_cpu8;
assign RCwire9_9 = to_cpu9;

assign CRwire1_1 = o_p1;
assign CRwire2_2 = o_p2;
assign CRwire3_3 = o_p3;
assign CRwire4_4 = o_p4;
assign CRwire5_5 = o_p5;
assign CRwire6_6 = o_p6;
assign CRwire7_7 = o_p7;
assign CRwire8_8 = o_p8;
assign CRwire9_9 = o_p9;

assign RRwire1_2 = out_right1;
assign RRwire1_4 = out_down1;
assign RRwire2_1 = out_left2;
assign RRwire2_3 = out_right2;
assign RRwire2_5 = out_down2;
assign RRwire3_2 = out_left3;
assign RRwire3_6 = out_down3;
assign RRwire4_5 = out_right4;
assign RRwire4_1 = out_up4;
assign RRwire4_7 = out_down4;
assign RRwire5_2 = out_up5;
assign RRwire5_4 = out_left5;
assign RRwire5_6 = out_right5;
assign RRwire5_8 = out_down5;
assign RRwire6_3 = out_up6;
assign RRwire6_5 = out_left6;
assign RRwire6_9 = out_down6;
assign RRwire7_4 = out_up7;
assign RRwire7_8 = out_right7;
assign RRwire8_5 = out_up8;
assign RRwire8_7 = out_left8;
assign RRwire8_9 = out_right8;
assign RRwire9_6 = out_up9;
assign RRwire9_8 = out_left9;





always 
	#1 clk = ~clk;

initial begin
	clk = 0;
	rst = 1;
	enable = 1;
	#10
	itw1 = 32'b01001010100000000000000000000000;
	itw2 = 32'b01001000010000000000000000000001;
	itw3 = 32'b01001000010000000000000000000001;
	#450 rst = 0;
	#900 $finish;
	
end

always @(posedge clk) begin

	in_p1 = RCwire1_1;
	in_p2 = RCwire2_2;
	in_p3 = RCwire3_3;
	in_p4 = RCwire4_4;
	in_p5 = RCwire5_5;
	in_p6 = RCwire6_6;
	in_p7 = RCwire7_7;
	in_p8 = RCwire8_8;
	in_p9 = RCwire9_9;

	from_cpu1 = CRwire1_1;
	from_cpu2 = CRwire2_2;
	from_cpu3 = CRwire3_3;
	from_cpu4 = CRwire4_4;
	from_cpu5 = CRwire5_5;
	from_cpu6 = CRwire6_6;
	from_cpu7 = CRwire7_7;
	from_cpu8 = CRwire8_8;
	from_cpu9 = CRwire9_9;

 	in_left2 = RRwire1_2;
 	in_up4 = RRwire1_4;
 	in_right1 = RRwire2_1;
 	in_left3 = RRwire2_3;
 	in_up5 = RRwire2_5;
 	in_right2 = RRwire3_2;
 	in_up6 = RRwire3_6;
 	in_left5 = RRwire4_5;
 	in_down1 = RRwire4_1;
 	in_up7 = RRwire4_7;
 	in_down2 = RRwire5_2;
 	in_right4 = RRwire5_4;
 	in_left6 = RRwire5_6;
 	in_up8 = RRwire5_8;
 	in_down3 = RRwire6_3;
 	in_right5 = RRwire6_5;
 	in_up9 = RRwire6_9;
 	in_down4 = RRwire7_4;
 	in_left8 = RRwire7_8;
 	in_down5 = RRwire8_5;
 	in_right7 = RRwire8_7;
 	in_left9 = RRwire8_9;
 	in_down6 = RRwire9_6;
 	in_right8 = RRwire9_8;


	

end
	

endmodule


