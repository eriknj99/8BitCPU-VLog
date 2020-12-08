/* I have no idea what this file is supposed to do but the assignment says that we need it to be our top level file.
   Does that mean that its the testbench or should it be one level below that???????
*/
module Processor (
   output wire [7:0] Address,
   input wire [7:0] Data,
   output wire [7:0] ACC_OUT,
   input wire clk,
   input wire rst
);
//data path group
wire [7:0] INC_in;//instructure internal
wire [3:0] opcode;//operation code
wire [3:0] imm;//immediate number
wire [7:0] regData_OUT;//Regester Data out rf
wire [7:0] regData_IN;//Regester Data into rf
wire [7:0] ALU_Result;//ALU Result
//control path group
wire Z;
wire C;
wire LoadIR;
wire IncPC;
wire SelPC;
wire LoadPC;
wire LoadReg;
wire LoadAcc;
wire [1:0] SelAcc;
wire [3:0] SelALU;

assign opcode=INC_in[7:4];
assign imm=INC_in[3:0];
assign ACC_OUT=regData_IN;
reg [1:0] debug;

always @(posedge clk ) begin
   // if (LoadIR == 1'b0) begin
   //    $display($time, " Command %b %b INST %h ACC %h ADD %h %h",Data[7:4],Data[3:0] ,Data ,regData_IN,Address,regData_OUT);
   //    $display($time, " ALU CON %b %b %b %b",SelALU,Z,C,ALU_Result);
   //    $display($time, " RF CON %b %h %h %h\n",LoadReg,regData_OUT,regData_IN,imm);
   // end
end
IR ir(
   //timing
	.clk (clk),
	.CLB (rst),
   //data path
   .I (INC_in),
   .LoadIR(LoadIR),
	.Instruction (Data)
);

program_counter pc(
   //data path
	.address (Address),
	.regIn (regData_OUT),
	.imm (imm),
   //control path
   .IncPC (IncPC),
   .LoadPC (LoadPC),
	.selPC (SelPC),
   //timing
   .clk (clk),
   .CLB (rst)
   
);

controller con(
   //control path
   .Z (Z),
	.C (C),
   .opcode (opcode),
   .LoadIR (LoadIR),
   .IncPC (IncPC),
   .SelPC (SelPC),
   .LoadPC (LoadPC),
   .LoadReg (LoadReg),
   .LoadAcc (LoadAcc),
   .SelAcc (SelAcc),
	.SelALU (SelALU),
   //timing
   .clk (clk),
   .CLB (rst)
);

reg_file rf(
   //data path
	.reg_out (regData_OUT),
	.reg_in (regData_IN),
	.RegAddr (imm),
   //control path
   .LoadReg (LoadReg),
   //timing
   .clk (clk),
   .CLB (rst)
   
);

ALU alu(
   //data path
	.a (regData_IN),
	.b (regData_OUT),
	.result (ALU_Result),
   //control path
   .ALU_sel (SelALU[3:2]),
   .load_shift (SelALU[1:0]),
   .cout (C),
   .zout (Z)
);

ACC acc(
   //data path
	.acc_out (regData_IN),
	.alu_in (ALU_Result),
	.reg_in (regData_OUT),
   .imm_in ({4'b0000,imm}),
   //control path
   .S1 (SelAcc[1]),
   .S0 (SelAcc[0]),
   .LoadACC (LoadAcc),
   //timing
   .clk (clk),
   .CLB (rst)
);
endmodule