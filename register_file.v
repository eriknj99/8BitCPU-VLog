//register file
module reg_file(
output wire [7:0] reg_out,

input wire [7:0] reg_in,
input wire [3:0] RegAddr,

input wire clk,
input wire CLB,
input wire LoadReg
);

reg [7:0] memory[15:0];
integer i;

always @(posedge clk or CLB)
begin
	if(CLB == 1'b0) begin
		for(i = 0; i < 15; i = i + 1) memory[i][7:0] = 0;
	end
	else begin
		if (LoadReg == 1'b1) memory[RegAddr] <= reg_in;
	end	
	// $display($time, " R0 %h R1 %h R2 %h R3 %h",memory[2'b00],memory[2'b01],memory[2'b10],memory[2'b11]);
end

assign reg_out = memory[RegAddr];

endmodule
