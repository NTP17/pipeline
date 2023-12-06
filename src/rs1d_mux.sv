module rs1d_mux (
	input  [31:0] rs1_dataD, rs1_dataE, rs1_dataM,
	input   [1:0] rs1d_sel,
	output logic [31:0] rs1d_out
);

	assign rs1d_out = (rs1d_sel == 2'h0) ? rs1_dataD :
	                  (rs1d_sel == 2'h1) ? rs1_dataE : rs1_dataM;

endmodule