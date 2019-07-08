`timescale 1ns / 1ps
module CPU(input clk, rst, memory_enable, counter, ins_mem_write,
 input signed [31:0] input_port, input [31:0] instruction_to_write, 
output signed [31:0] alu_result, output reg signed [31:0] output_port,
 output [31:0] PC, IR, output [7:0] flag_register);

parameter n = 4194304;
wire RES = 0;
reg [31:0] current_pc;
wire [31:0] next_pc;
wire [4:0] opcode;

reg signed [31:0] R_in;
wire signed [31:0] R_out;

wire [31:0] pc1 = current_pc + 1;

always @(posedge clk) begin
	$display("PC = %h",current_pc);
	$display("IR = %b",current_ir);
	if (opcode == 5'b11000) 
		R_in = input_port;
	if (opcode == 5'b11001)
		output_port = R_out;
	if (rst) begin
		current_pc <= n/2;
		R_in <= 0;
	end
	else if(opcode != 5'b11111)
		current_pc <= next_pc;
end



//defining output of modules
wire rwr, ma1, op1, mem_write,
 reg_write, rFI, rFO, sFO, ION,IOF;  // controller outputs
wire [1:0] pc_selector, rwd, mem_read, op2;  //controller outputs
wire [2:0] ALUOp;  //controller output

wire V,C,Z,S;  //ALU flag outputs
wire signed [31:0] alu_res;  //ALU result output

wire signed [31:0] reg_data1, reg_data2;  //register file outputs

wire signed [31:0] mem_data1, mem_data2;  //memory data outputs
wire [31:0] current_ir;  //memory instruction output
//end defining output of modules

wire [21:0] twenty_one_to_zero = current_ir[21:0];

//defining input of modules
//RegisterFile inputs
wire [4:0] reg1, reg2, write_reg;

wire signed [31:0] register_write_data;
assign reg1 = current_ir[26:22];
assign reg2 = current_ir[21:17];
assign write_reg = (rwr == 0) ? current_ir[16:12] : current_ir[26:22];
assign register_write_data = (rwd == 0) ? alu_res : 
((rwd == 2)? mem_data1  :({{10{twenty_one_to_zero[21]}},twenty_one_to_zero}));

//ALU inputs
wire signed [31:0] operand1 = (op1 == 0) ? reg_data1 : mem_data1;
wire signed [31:0] operand2 = (op2 == 0) ? reg_data2 : 
((op2 == 1) ? mem_data2 :((op2 == 2)? 1 : -1 ) ) ;

//Memory inputs
wire [31:0] address1 = (ma1 == 0) ? reg_data1 : {{10{1'b0}},
 twenty_one_to_zero};
wire [31:0] address2 = reg_data2;
// current_pc is instruction address
wire signed[31:0] memory_write_data = reg_data1;

//Controller inputs
assign opcode = current_ir[31:27];
//end defining input of modules


//instantiating modules
//instantiate RegisterFile
RegisterFile rf(reg_data1, reg_data2, R_out, reg1, reg2, write_reg,
 register_write_data, R_in, reg_write, clk, rst);

// instantiate ALU
ALU alu(alu_res, V, C, Z, S, operand1, operand2, ALUOp);

// instantiate Memory
Memory memory(mem_data1, mem_data2, current_ir, address1, address2,
current_pc, memory_write_data, instruction_to_write, rst, EN, clk, mem_write, counter, ins_mem_write, mem_read);

// instantiate Controller
Control control(opcode, rst, rwr, ma1,op1,mem_write, reg_write, rFI, rFO,
sFO, ION, IOF, pc_selector, rwd, mem_read, op2,ALUOp);
//end instantiating modules

assign PC = current_pc;
assign IR = current_ir;
assign alu_result = alu_res;

//define flags and flag register
wire INT = ION ? 1 : (IOF ? 0 : INT);
wire FI = rFI ? 0 : FI;
wire FO = rFO ? 0 : (sFO ? 1 : FO);
assign flag_register = {V, C, Z, S, INT, FI, FO, RES};

// handling program counter (PC) ...
wire [31:0] tw1 = {{10{1'b0}},twenty_one_to_zero};
wire [31:0] tw6 = {{5{1'b0}}, current_ir[26:0]};
wire [1:0] pc_slctor = (opcode != 5'b01011) ? pc_selector : Z;
assign next_pc = (pc_slctor == 0) ? pc1 : (pc_slctor == 1 ? tw6 : tw1);

endmodule
