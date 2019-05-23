module CPU(input clk, rst, memory_enable, output signed [31:0] alu_result,
 PC, IR, R_in, R_out, output [7:0] flag_register);

parameter n = 2097152;
wire RES = 0;
reg [31:0] R_IN, R_OUT;
reg [31:0] current_pc;

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
wire [31:0] register_write_data;
assign reg1 = current_ir[26:22];
assign reg2 = current_ir[21:17];
assign write_reg = (rwr == 0) ? current_ir[16:12] : reg1;
assign register_write_data = (rwd == 0) ? alu_res : 
((rwd == 1)? {{10{twenty_one_to_zero[21]}},twenty_one_to_zero} : mem_data1);

//ALU inputs
wire signed [31:0] operand1 = (op1 == 0) ? reg_data1 : mem_data1;
wire signed [31:0] operand2 = (op2 == 0) ? reg_data2 : 
((op2 == 1) ? mem_data2 :((op2 == 2)? 1 : -1 ) ) ;

//Memory inputs
wire address1 = (ma1 == 0) ? reg_data1 : {{10{twenty_one_to_zero[21]}},
 twenty_one_to_zero};
wire address2 = reg_data2;
wire instruction_address = current_pc;
wire memory_write_data = reg_data1;

//Controller inputs
wire [4:0] opcode = current_ir[31:27];
//end defining input of modules


//instantiating modules
//instantiate RegisterFile
RegisterFile rf(reg_data1, reg_data2, reg1, reg2, write_reg,
 register_write_data, reg_write, clk, rst);

// instantiate ALU
ALU alu(alu_res, V, C, Z, S, operand1, operand2, ALUOp);

// instantiate Memory
Memory memory(mem_data1, mem_data2, current_ir, address1, address2,
instruction_address, memory_write_data, rst, EN, clk, mem_write, mem_read);

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

// handling program counter (PC)



endmodule
