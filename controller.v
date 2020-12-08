module controller(Z,C,clk,CLB,opcode, LoadIR,IncPC,SelPC,LoadPC,LoadReg,LoadAcc,SelAcc,SelALU);
input   wire Z;
input   wire C;
input   wire clk;
input   wire CLB;
input   wire [3:0] opcode;
output  wire LoadIR;
output  wire IncPC;
output  wire SelPC;
output  wire LoadPC;
output  wire LoadReg;
output  wire LoadAcc;
output  wire [1:0] SelAcc;
output  wire [3:0] SelALU;

reg [11:0] OPDATA;
reg state;

always @(posedge clk or CLB) begin
	if (CLB == 1'b0) begin
        state <= 1'b0;
	end
	else begin
		case(state)
			1'b0:
				state <= 1'b1;
			1'b1:
				state <= 1'b0;
		endcase
	end
end

always @(*) begin
	if(CLB == 1'b1) begin
		case({state,opcode})
			5'b00001: begin 
				// LoadIR <= 0; 
				// IncPC <= 1; 
				// SelPC <= 0; 
				// LoadPC <= 0; //1  ADD
				// LoadReg <= 0; 
				// LoadAcc <= 1; 
				// SelALU <= 4'b1000; 
				// SelAcc <= 2'b00; 
					//12'b010001 1000 00
				OPDATA<=12'b010001100000;
			end
			5'b00010: begin
				// LoadIR <= 0; 
				// IncPC <= 1; 
				// SelPC <= 0; 
				// LoadPC <= 0; //2  SUB
				// LoadReg <= 0; 
				// LoadAcc <= 1; 
				// SelALU <= 4'b1100; 
				// SelAcc <= 2'b00; 
				// 12'b010001 1100 00
				OPDATA<=12'b010001110000;
			end
			5'b00011: begin
				// LoadIR <= 0; 
				// IncPC <= 1; 
				// SelPC <= 0; 
				// LoadPC <= 0; //3  NOR
				// LoadReg <= 0; 
				// LoadAcc <= 1; 
				// SelALU <= 4'b0100; 
				// SelAcc <= 2'b00; 
				// 12'b010001 0100 00
				OPDATA<=12'b010001010000;
			end
			5'b00100: begin
				// LoadIR <= 0; 
				// IncPC <= 1; 
				// SelPC <= 0; 
				// LoadPC <= 0; //4  ACC <- REG
				// LoadReg <= 0; 
				// LoadAcc <= 1; 
				// SelALU <= 4'b0000; 
				// SelAcc <= 2'b10; 
				// 12'b010001 0000 10
				OPDATA<=12'b010001000010;
			end
			5'b00101: begin
				// LoadIR <= 0; 
				// IncPC <= 1; 
				// SelPC <= 0; 
				// LoadPC <= 0; //5  REG <- ACC
				// LoadReg <= 1; 
				// LoadAcc <= 0; 
				// SelALU <= 4'b0010; 
				// SelAcc <= 2'b00; 
				// 12'b010010 0010 00
				OPDATA<=12'b010010001000;
			end
			5'b00110: begin
				// LoadIR <= 0; 
				// IncPC <=~Z; 
				// SelPC <= 1; 
				// LoadPC <= Z; //6  IF Z: PC <- REG 
				// LoadReg <= 0; 
				// LoadAcc <= 0; 
				// SelALU <= 4'b0000; 
				// SelAcc <= 2'b00; 
				// 12'b0~Z1Z00 0000 00
				OPDATA<={1'b0
						,~Z
						,1'b1
						,Z
						,2'b00
						,4'b0010
						,2'b00};
			end
			5'b00111: begin
				// LoadIR <= 0; 
				// IncPC <=~Z; 
				// SelPC <= 0; 
				// LoadPC <= Z; //7  IF Z: PC <- IMM
				// LoadReg <= 0; 
				// LoadAcc <= 0; 
				// SelALU <= 4'b0000; 
				// SelAcc <= 2'b00; 
				// 12'b0~Z0Z00 0000 00
				OPDATA<={1'b0
						,~Z
						,1'b0
						,Z
						,2'b00
						,4'b0010
						,2'b00};
			end
			5'b01000: begin
				// LoadIR <= 0; 
				// IncPC <=~C; 
				// SelPC <= 1; 
				// LoadPC <= C; //8  IF C: PC <- REG
				// LoadReg <= 0; 
				// LoadAcc <= 0; 
				// SelALU <= 4'b0000; 
				// SelAcc <= 2'b00; 
				// 12'b0~C1C00 0000 00
				OPDATA<={1'b0,
						~C,
						1'b1
						,C
						,2'b00
						,4'b0010
						,2'b00};
			end
			5'b01010: begin
				// LoadIR <= 0; 
				// IncPC <=~C; 
				// SelPC <= 0; 
				// LoadPC <= C; //10 IF C: PC <- IMM
				// LoadReg <= 0; 
				// LoadAcc <= 0; 
				// SelALU <= 4'b0000; 
				// SelAcc <= 2'b00; 
				// 12'b0~C0C00 0000 00
				OPDATA<={1'b0,
						~C,
						1'b0
						,C
						,2'b00
						,4'b0010
						,2'b00};
			end
			5'b01011: begin
				// LoadIR <= 0; 
				// IncPC <= 1; 
				// SelPC <= 0; 
				// LoadPC <= 0; //11 ACC <- ACC << 1
				// LoadReg <= 0; 
				// LoadAcc <= 1; 
				// SelALU <= 4'b0001; 
				// SelAcc <= 2'b00; 
				// 12'b010001 0001 00
				OPDATA<=12'b010001000100;
			end
			5'b01100: begin
				// LoadIR <= 0; 
				// IncPC <= 1; 
				// SelPC <= 0; 
				// LoadPC <= 0; //12 ACC <- aCC >> 1 
				// LoadReg <= 0; 
				// LoadAcc <= 1; 
				// SelALU <= 4'b0001; 
				// SelAcc <= 2'b00; 
				// 12'b010001 0001 00
				OPDATA<=12'b010001000100;
			end
			5'b01101: begin
				// LoadIR <= 0; 
				// IncPC <= 1; 
				// SelPC <= 0; 
				// LoadPC <= 0; //13 ACC <- IMM
				// LoadReg <= 0; 
				// LoadAcc <= 1;
				// SelALU <= 4'b0000; 
				// SelAcc <= 2'b11; 
				// 12'b010001 0000 11
				OPDATA<=12'b010001001011;
			end
			5'b00000: begin
				// LoadIR <= 0; 
				// IncPC <= 1; 
				// SelPC <= 0; 
				// LoadPC <= 0; //0  WAIT
				// LoadReg <= 0; 
				// LoadAcc <= 0; 
				// SelALU <= 4'b0000; 
				// SelAcc <= 2'b00; 
				// 12'b010000 0000 00
				OPDATA<=12'b010000001000;
			end
			5'b01111: begin
				// LoadIR <= 0; 
				// IncPC <= 0; 
				// SelPC <= 0; 
				// LoadPC <= 0; //15 STOP
				// LoadReg <= 0; 
				// LoadAcc <= 0; 
				// SelALU <= 4'b0000; 
				// SelAcc <= 2'b00; 
				// 12'b000000 0000 00
				OPDATA<=12'b000000001000;
			end
			default: begin
				// LoadIR <= 0; 
				// IncPC <= 0; 
				// SelPC <= 0; 
				// LoadPC <= 0; //15 STOP
				// LoadReg <= 0; 
				// LoadAcc <= 0; 
				// SelALU <= 4'b0000; 
				// SelAcc <= 2'b00; 
				// 12'b000000 0010 00
				OPDATA<=12'b100000001000;
			end
		endcase
	end
	else
		OPDATA<=12'b100000001000;
	
end
	assign LoadIR	= OPDATA[11];
	assign IncPC	= OPDATA[10];
	assign SelPC	= OPDATA[9];
	assign LoadPC	= OPDATA[8];
	assign LoadReg 	= OPDATA[7];  
	assign LoadAcc	= OPDATA[6]; 
	assign SelALU	= OPDATA[5:2]; 
	assign SelAcc	= OPDATA[1:0]; 
endmodule