module op_a_mux (
	input [12:0] pc,
	input [31:0] rs1_data,
	input op_a_sel,
	output [31:0] operand_a
);

	assign operand_a = (op_a_sel) ? {19'h0,pc} : rs1_data;

endmodule