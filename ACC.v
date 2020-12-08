//register file
module ACC(
output wire [7:0] acc_out,

input wire [7:0] alu_in,
input wire [7:0] reg_in,
input wire [7:0] imm_in,

input wire S1,
input wire S0,

input wire clk,
input wire CLB,
input wire LoadACC
);

reg [7:0] memory;
integer i;
wire [7:0] dataIn;

assign dataIn=(S1)?((S0)?imm_in:reg_in):alu_in;
assign acc_out = memory;

always @(posedge clk or CLB)
begin
	if(CLB == 1'b0) begin
		memory[7:0] <= 0;
	end
	else begin
		if (LoadACC == 1'b1) memory <= dataIn;
		else memory<=memory;
	end
end



endmodule