`timescale 1ns / 1ps
module Router(input [15:0] x,input [15:0] y,input [63:0] in_left, in_right, in_up, in_down, 
input signed[31:0] from_cpu, input [15:0] in_x_cpu, in_y_cpu,
 output reg [63:0] left, right, up, down,
 output reg signed [31:0] to_cpu, output reg set_fi);

//data is the part [31:0] of 64 bit data
// [63:48] is y and [47:32] is x

//parameter x = 1, y = 1;

always @(in_left)
	packet_reached(in_left);
always @(in_right)
	packet_reached(in_right);
always @(in_up)
	packet_reached(in_up);
always @(in_down)
	packet_reached(in_down);
always @(from_cpu) begin
	if (x < in_x_cpu) begin
		right = {in_y_cpu, in_x_cpu, from_cpu};
	end
	else if(x > in_x_cpu) begin
		left = {in_y_cpu, in_x_cpu, from_cpu};
	end
	else if(y > in_y_cpu) begin
		up = {in_y_cpu, in_x_cpu, from_cpu};
	end
	else if(y < in_y_cpu) begin
		down = {in_y_cpu, in_x_cpu, from_cpu};
	end
end


//define a task for when a data is received
task packet_reached;
input reg [63:0] a;
reg [15:0] in_x, in_y;  // target x and y
begin
	in_x = a[47:32];
	in_y = a[63:48];
	
	if (x == in_x && y == in_y) begin
		to_cpu = a[31:0];
		set_fi = 1;
		#5 set_fi = 0;
	end
	else if(x < in_x) //send to right
		right = a;
	else if(x > in_x)
		left = a;
	else if(y > in_y)
		up = a;
	else
		down = a;
end
endtask

endmodule
		
	
		