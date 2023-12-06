module alu (
	input  [31:0] operand_a,
	input  [31:0] operand_b,
	input  [3:0]  alu_op,
	output logic [31:0] alu_data
);

	localparam ADD  = 4'h0;
	localparam SUB  = 4'h1;
	localparam SLT  = 4'h2;
	localparam SLTU = 4'h3;
	localparam XOR  = 4'h4;
	localparam OR   = 4'h5;
	localparam AND  = 4'h6;
	localparam SLL  = 4'h7;
	localparam SRL  = 4'h8;
	localparam SRA  = 4'h9;

	wire [32:0] ua, ub, uc;
	wire [31:0] c, s;
	
	assign ua = {1'b0,operand_a};
	assign ub = {1'b0,operand_b};
	assign uc =        ua + ~       ub + 33'h1;
	assign  c = operand_a + ~operand_b + 32'h1;

	arith_right_shift ars (
		.din(operand_a),
		.amount(operand_b[4:0]),
		.dout(s)
	);

	always_comb
	case (alu_op)
		ADD:  alu_data =  operand_a + operand_b;
		SUB:  alu_data =  operand_a + ~operand_b + 32'h1;
		SLT:  alu_data = (c[31])  ? 32'h1 : 32'h0;
		SLTU: alu_data = (uc[32]) ? 32'h1 : 32'h0;
		XOR:  alu_data =  operand_a ^ operand_b;
		OR:   alu_data =  operand_a | operand_b;
		AND:  alu_data =  operand_a & operand_b;
		SLL:  alu_data =  operand_a << operand_b[4:0];
		SRL:  alu_data =  operand_a >> operand_b[4:0];
		SRA:  alu_data =  s;
		default: alu_data = 32'h0;
	endcase

endmodule

//############################################
// >>> is useless, so I had to make one my own
//############################################

module arith_right_shift (
	input  [31:0] din,
	input   [4:0] amount,
	output logic [31:0] dout
);

	wire [31:0] logic_shift;
	
	assign logic_shift = din >> amount;
	
	always_comb
		if (din[31])
			case (amount)
				5'd0 : dout = logic_shift;
				5'd1 : dout = logic_shift | 32'b10000000000000000000000000000000;
				5'd2 : dout = logic_shift | 32'b11000000000000000000000000000000;
				5'd3 : dout = logic_shift | 32'b11100000000000000000000000000000;
				5'd4 : dout = logic_shift | 32'b11110000000000000000000000000000;
				5'd5 : dout = logic_shift | 32'b11111000000000000000000000000000;
				5'd6 : dout = logic_shift | 32'b11111100000000000000000000000000;
				5'd7 : dout = logic_shift | 32'b11111110000000000000000000000000;
				5'd8 : dout = logic_shift | 32'b11111111000000000000000000000000;
				5'd9 : dout = logic_shift | 32'b11111111100000000000000000000000;
				5'd10: dout = logic_shift | 32'b11111111110000000000000000000000;
				5'd11: dout = logic_shift | 32'b11111111111000000000000000000000;
				5'd12: dout = logic_shift | 32'b11111111111100000000000000000000;
				5'd13: dout = logic_shift | 32'b11111111111110000000000000000000;
				5'd14: dout = logic_shift | 32'b11111111111111000000000000000000;
				5'd15: dout = logic_shift | 32'b11111111111111100000000000000000;
				5'd16: dout = logic_shift | 32'b11111111111111110000000000000000;
				5'd17: dout = logic_shift | 32'b11111111111111111000000000000000;
				5'd18: dout = logic_shift | 32'b11111111111111111100000000000000;
				5'd19: dout = logic_shift | 32'b11111111111111111110000000000000;
				5'd20: dout = logic_shift | 32'b11111111111111111111000000000000;
				5'd21: dout = logic_shift | 32'b11111111111111111111100000000000;
				5'd22: dout = logic_shift | 32'b11111111111111111111110000000000;
				5'd23: dout = logic_shift | 32'b11111111111111111111111000000000;
				5'd24: dout = logic_shift | 32'b11111111111111111111111100000000;
				5'd25: dout = logic_shift | 32'b11111111111111111111111110000000;
				5'd26: dout = logic_shift | 32'b11111111111111111111111111000000;
				5'd27: dout = logic_shift | 32'b11111111111111111111111111100000;
				5'd28: dout = logic_shift | 32'b11111111111111111111111111110000;
				5'd29: dout = logic_shift | 32'b11111111111111111111111111111000;
				5'd30: dout = logic_shift | 32'b11111111111111111111111111111100;
				5'd31: dout = logic_shift | 32'b11111111111111111111111111111110;
			endcase
		else dout = logic_shift;

endmodule