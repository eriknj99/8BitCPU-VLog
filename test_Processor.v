
module test_Processor 
#(parameter MEMWIDTH = 8)
();

reg [MEMWIDTH-1:0] memory[23:0];
reg [MEMWIDTH-1:0] TestMem[34:0];
wire [7:0] address;
wire [7:0] data;
wire [7:0] ACC;
reg clk;
reg clk_Add;
reg rst;
reg [7:0] testAddress;
assign data=memory[address];

initial
begin
	$readmemh("8BitCPU-VLog-master/test_Processor.txt", memory);
	$readmemh("8BitCPU-VLog-master/Exception.txt", TestMem);
	clk = 0;
	clk_Add = 0;
	rst = 0;
	testAddress=0;
	#3 rst = 1;
	#685 $stop;
end

always begin
#5 clk = ~clk;
end

always @(posedge clk) begin
	clk_Add <= ~clk_Add;
end

always @(posedge clk_Add) begin
	testAddress <= testAddress + 1;
	if(TestMem[testAddress] !== address)
		$error("Address= %h expected = %h ACC = %h",address,TestMem[testAddress],ACC);
	else
		$display($time, " correct results %h %h\n",TestMem[testAddress],address);
end


Processor p(
	.Address (address),
	.Data (data),
	.clk (clk),
	.ACC_OUT(ACC),
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