module pc_reg (
	input clk, rstn, en,
	input [12:0] next_pc,
	output logic [12:0] pc
);

	always_ff @ (posedge clk, negedge rstn)
		if (!rstn) pc = 0;
		else if (en) pc = {next_pc[12:1],1'b0};

endmodule