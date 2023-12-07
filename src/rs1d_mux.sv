module rs1d_mux (
	input  [31:0] rs1_dataD, alu_dataE, alu_dataM, ld_dataM,
	input   [1:0] rs1d_sel,
	output logic [31:0] rs1d_out
);

	assign rs1d_out = (rs1d_sel == 2'b00) ? rs1_dataD :
	                  (rs1d_sel == 2'b01) ? alu_dataE :
					  (rs1d_sel == 2'b10) ? alu_dataM : ld_dataM;

endmodule