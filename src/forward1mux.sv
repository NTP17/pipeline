module forward1mux (
	input  [31:0] rs1_dataE, alu_dataM, wb_data,
	input   [1:0] forward1sel,
	output [31:0] forward1out
);

	assign forward1out = (forward1sel == 2'b00) ? rs1_dataE :
	                     (forward1sel == 2'b01) ? alu_dataM : wb_data;

endmodule