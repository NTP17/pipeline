module forward2mux (
	input  [31:0] rs2_dataE, alu_dataM, wb_data, ld_dataM,
	input   [1:0] forward2sel,
	output [31:0] forward2out
);

	assign forward2out = (forward2sel == 2'h0) ? rs2_dataE :
	                     (forward2sel == 2'h1) ? alu_dataM : 
						 (forward2sel == 2'h2) ? wb_data : ld_dataM;

endmodule