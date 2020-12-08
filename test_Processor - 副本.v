
module test_Processor 
#(parameter MEMWIDTH = 24)
();

reg [MEMWIDTH-1:0] memory[23:0];
wire [7:0] address;
wire [7:0] data;
reg clk;
reg rst;

assign data=memory[address][23:15];

initial
begin
	$readmemh("8BitCPU-VLog-master/test_Processor.txt", memory);
	clk = 0;
	rst = 0;
	#20 rst = 1;
	// #900 $stop;
end

always begin
#5 clk = ~clk;
end

Processor p(
	.Address (address),
	.Data (data),
	.clk (clk),
	.rst (rst)
);

endmodule



// reg clk;

// wire [7:0] a, b, r;
// wire [1:0] alu_ctrl, alu_shift;
// wire c, z;
// wire [9:0] expected;

// assign a = memory[address][31:24];
// assign b = memory[address][23:16];
// assign alu_ctrl = memory[address][15:14];
// assign alu_shift = memory[address][13:12];
// assign expected = memory[address][9:0];
// ALU dut(
// 	.a (a),
// 	.b (b),
// 	.ALU_sel (alu_ctrl),
// 	.load_shift (alu_shift),
// 	.cout (c),
// 	.zout (z),
// 	.result (r)
// );

// always @(posedge clk) begin
// 	address <= address + 1;
// 	if(expected !== {z, c, r} || expected === 10'bx)
// 		$error("a=%h, b=%h, ALU_sel=%2b, load_shift=%2b, expected=%h, received =%h\n",a, b, alu_ctrl, alu_shift, expected, {z, c, r});
// 	else
// 		$display($time, " correct results a=%h b=%h result=%h\n", a, b, {c, r});
	
// end