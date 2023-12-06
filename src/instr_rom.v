module instr_rom (
	input  [12:0] pc,
	output [31:0] instr
);

	reg [31:0] mem [0:11'h7ff];

	initial $readmemh("../mem/ALL_test.mem", mem);
	//initial $readmemh("../mem/ALL_testbench.mem", mem);

	assign instr = mem[pc[12:2]];

endmodule
