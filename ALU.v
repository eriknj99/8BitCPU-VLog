
module ALU (a, b, ALU_sel, load_shift, result, cout, zout);
input [7:0] a, b;
input [1:0] ALU_sel, load_shift;
output[7:0] result;
output cout, zout;

wire cout, zout;
reg [8:0] r;

always @(a or b or ALU_sel or load_shift) begin
	case(ALU_sel) 
		2'b10: r <= a + b; //add
		2'b11: r <= a - b; //subtract
		2'b01: begin
			r <= ~(a | b); //NOR
			r[8] <= 0; // I need to set the carry bit to zero manually because A[8] = 0 and B[8] = 0. Without this line carry out will always be 1 
			end
		2'b00: 
			begin
			case(load_shift)
				2'b00: r <= 0;
				2'b10: r <= a;
				2'b11: r <= a >> 1;
				2'b01: r <= a << 1;
			endcase
			end
	endcase
end

assign cout = r[8];
assign result = r[7:0];
assign zout = r[7:0] == 0;

endmodule

