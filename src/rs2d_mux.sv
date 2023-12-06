module rs2d_mux (
	input  [31:0] rs2_dataD, rs2_dataE, rs2_dataM,
	input   [1:0] rs2d_sel,
	output logic [31:0] rs2d_out
);

	assign rs2d_out = (rs2d_sel == 2'h0) ? rs2_dataD :
	                  (rs2d_sel == 2'h1) ? rs2_dataE : rs2_dataM;

endmodule