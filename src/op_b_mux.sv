module op_b_mux (
	input [31:0] imm, rs2_data,
	input op_b_sel,
	output [31:0] operand_b
);

	assign operand_b = (op_b_sel) ? imm : rs2_data;

endmodule