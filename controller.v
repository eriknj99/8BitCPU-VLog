module controller(Z,C,CLK,CLB,opcode, LoadIR,IncPC,PelPC,LoadPC,LoadReg,LoadAcc,SelAcc,SelALU);
input   wire Z;
input   wire C;
input   wire CLK;
input   wire CLB;
input   wire [3:0] opcode
output  wire LoadIR;
output  wire IncPC;
output  wire SelPC;
output  wire LoadPC;
output  wire LoadReg;
output  wire LoadAcc;
output  wire [1:0] SelAcc;
output  wire [3:0] SelALU;


always @(posedge clk) begin

case(opcode)
	2'b0001: LoadIR <= 0; LoadReg <= 0; LoadACC <= 1; IncPC <= 1; SelPC <= 0; SelALU <= 4'b1000; SelAcc <= 2'b00; LoadPC <= 0; //1  ADD
	2'b0010: LoadIR <= 0; LoadReg <= 0; LoadACC <= 1; IncPC <= 1; SelPC <= 0; SelALU <= 4'b1100; SelAcc <= 2'b00; LoadPC <= 0; //2  SUB
	2'b0011: LoadIR <= 0; LoadReg <= 0; LoadACC <= 1; IncPC <= 1; SelPC <= 0; SelALU <= 4'b0100; SelAcc <= 2'b00; LoadPC <= 0; //3  NOR
	2'b0100: LoadIR <= 0; LoadReg <= 0; LoadACC <= 1; IncPC <= 1; SelPC <= 0; SelALU <= 4'b0000; SelAcc <= 2'b10; LoadPC <= 0; //4  ACC <- REG
	2'b0101: LoadIR <= 0; LoadReg <= 1; LoadACC <= 0; IncPC <= 1; SelPC <= 0; SelALU <= 4'b0000; SelAcc <= 2'b00; LoadPC <= 0; //5  REG <- ACC
	2'b0110: LoadIR <= 0; LoadReg <= 0; LoadACC <= 0; IncPC <=~Z; SelPC <= 1; SelALU <= 4'b0000; SelAcc <= 2'b00; LoadPC <= Z; //6  IF Z: PC <- REG 
	2'b0111: LoadIR <= 0; LoadReg <= 0; LoadACC <= 0; IncPC <=~Z; SelPC <= 0; SelALU <= 4'b0000; SelAcc <= 2'b00; LoadPC <= Z; //7  IF Z: PC <- IMM
	2'b1000: LoadIR <= 0; LoadReg <= 0; LoadACC <= 0; IncPC <=~C; SelPC <= 1; SelALU <= 4'b0000; SelAcc <= 2'b00; LoadPC <= C; //8  IF C: PC <- REG
	2'b1010: LoadIR <= 0; LoadReg <= 0; LoadACC <= 0; IncPC <=~C; SelPC <= 0; SelALU <= 4'b0000; SelAcc <= 2'b00; LoadPC <= C; //10 IF C: PC <- IMM
	2'b1011: LoadIR <= 0; LoadReg <= 0; LoadACC <= 1; IncPC <= 1; SelPC <= 0; SelALU <= 4'b0011; SelAcc <= 2'b00; LoadPC <= 0; //11 ACC <- ACC << 1
	2'b1100: LoadIR <= 0; LoadReg <= 0; LoadACC <= 1; IncPC <= 1; SelPC <= 0; SelALU <= 4'b0001; SelAcc <= 2'b00; LoadPC <= 0; //12 ACC <- aCC >> 1 
	2'b1101: LoadIR <= 0; LoadReg <= 0; LoadACC <= 1; IncPC <= 1; SelPC <= 0; SelALU <= 4'b0000; SelAcc <= 2'b11; LoadPC <= 0; //13 ACC <- IMM
	2'b0000: LoadIR <= 0; LoadReg <= 0; LoadACC <= 0; IncPC <= 1; SelPC <= 0; SelALU <= 4'b0000; SelAcc <= 2'b00; LoadPC <= 0; //0  WAIT
	2'b1111: LoadIR <= 0; LoadReg <= 0; LoadACC <= 0; IncPC <= 0; SelPC <= 0; SelALU <= 4'b0000; SelAcc <= 2'b00; LoadPC <= 0; //15 STOP

endcase

end

ALU dut(
	.ALU_sel (SelALU[3:2]),
	.load_shift (SelALU[3:2]),
	.cout (C),
	.zout (Z)
);

IR dut(
	.LoadIR (LoadIR)
);

program_counter dut(
	.IncPC (IncPC),
	.LoadPC (LoadPC),
	.selPC (SelPC)
);

register_file dut(
	.LoadReg (LoadReg)
)

ACC dut(
	.LoadACC (LoadAcc),
	.S0 (SelAcc[0]),
	.S1 (SelAcc[1])
);