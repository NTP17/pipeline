module forward2mux (
	input  [31:0] rs2_dataE, alu_dataM, wb_data,
	input   [1:0] forward2sel,
	output [31:0] forward2out
);

	assign forward2out = (forward2sel == 2'b00) ? rs2_dataE :
	                     (forward2sel == 2'b01) ? alu_dataM : wb_data;

endmodule