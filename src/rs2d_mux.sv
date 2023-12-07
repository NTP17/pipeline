module rs2d_mux (
	input  [31:0] rs2_dataD, alu_dataE, alu_dataM, ld_dataM,
	input   [1:0] rs2d_sel,
	output logic [31:0] rs2d_out
);

	assign rs2d_out = (rs2d_sel == 2'b00) ? rs2_dataD :
	                  (rs2d_sel == 2'b01) ? alu_dataE :
					  (rs2d_sel == 2'b10) ? alu_dataM : ld_dataM;

endmodule