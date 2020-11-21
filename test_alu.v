//test ALU
module test_ALU 
#(parameter MEMWIDTH = 32)
();

reg [MEMWIDTH-1:0] memory[15:0];
reg clk;
reg [3:0] address;
wire [7:0] a, b, r;
wire [1:0] alu_ctrl, alu_shift;
wire c, z;
wire [9:0] expected;

assign a = memory[address][31:24];
assign b = memory[address][23:16];
assign alu_ctrl = memory[address][15:14];
assign alu_shift = memory[address][13:12];
assign expected = memory[address][9:0];

initial
begin
	$readmemh("test_alu.txt", memory);
	clk = 0;
	address = 0;
	#200 $stop;
end

always begin
#5 clk = ~clk;
end

always @(posedge clk) begin
	address <= address + 1;
	if(expected !== {z, c, r} || expected === 10'bx)
		$error("a=%h, b=%h, ALU_sel=%2b, load_shift=%2b, expected=%h, received =%h\n",a, b, alu_ctrl, alu_shift, expected, {z, c, r});
	else
		$display($time, " correct results a=%h b=%h result=%h\n", a, b, {c, r});
	
end

ALU dut(
	.a (a),
	.b (b),
	.ALU_sel (alu_ctrl),
	.load_shift (alu_shift),
	.cout (c),
	.zout (z),
	.result (r)
);

endmodule

