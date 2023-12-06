module lsu (
	input clk_i, rst_ni, st_en,
	input [11:0] addr,
	input [3:0] byte_en,
	input [2:0] ld_sel,
	input [31:0] st_data, io_sw,
	output [31:0] ld_data, io_lcd, io_ledg, io_ledr, io_hex0, io_hex1, io_hex2, io_hex3, io_hex4, io_hex5, io_hex6, io_hex7
);

	logic data_we, out_we, in_we;
	logic [31:0] data_wire, out_wire, in_wire, sw_wire, ld_wire;
	logic [8:0] da;
	logic [5:0] oa, ia;

	addr_dec ad (
		.main_addr(addr),
		.main_we(st_en),
		.data_addr(da),
		.out_addr(oa),
		.in_addr(ia),
		.data_en(data_we),
		.out_en(out_we),
		.in_en(in_we)
	);

	latch32_cp sw (.A(addr), .B(12'h900), .ins(io_sw), .outs(sw_wire));

	datamem dmem (.clock(!clk_i), .wren(data_we), .address(da), .byteena(byte_en), .data(st_data), .q(data_wire));
	outmem  omem (.clock(!clk_i), .wren(out_we),  .address(oa), .byteena(byte_en), .data(st_data), .q(out_wire));
	inmem   imem (.clock(!clk_i), .wren(in_we),   .address(ia), .byteena(4'b1111), .data(sw_wire), .q(in_wire));

	reg32_cp hex0 (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h800), .byte_en(byte_en), .ins(st_data), .outs(io_hex0));
	reg32_cp hex1 (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h810), .byte_en(byte_en), .ins(st_data), .outs(io_hex1));
	reg32_cp hex2 (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h820), .byte_en(byte_en), .ins(st_data), .outs(io_hex2));
	reg32_cp hex3 (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h830), .byte_en(byte_en), .ins(st_data), .outs(io_hex3));
	reg32_cp hex4 (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h840), .byte_en(byte_en), .ins(st_data), .outs(io_hex4));
	reg32_cp hex5 (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h850), .byte_en(byte_en), .ins(st_data), .outs(io_hex5));
	reg32_cp hex6 (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h860), .byte_en(byte_en), .ins(st_data), .outs(io_hex6));
	reg32_cp hex7 (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h870), .byte_en(byte_en), .ins(st_data), .outs(io_hex7));
	reg32_cp ledr (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h880), .byte_en(byte_en), .ins(st_data), .outs(io_ledr));
	reg32_cp ledg (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h890), .byte_en(byte_en), .ins(st_data), .outs(io_ledg));
	reg32_cp lcd  (.clk(clk_i), .rstn(rst_ni), .en(st_en), .A(addr), .B(12'h8A0), .byte_en(byte_en), .ins(st_data), .outs(io_lcd));

	ld_mux loader (.main_addr(addr), .mem_data(data_wire), .out_data(out_wire), .in_data(in_wire), .data_out(ld_wire));

    ld_sel_mux lsm (
        .LW(ld_wire),
        .LB(ld_wire[7:0]),
        .LBU(ld_wire[7:0]),
        .LH(ld_wire[15:0]),
        .LHU(ld_wire[15:0]),
        .ld_sel(ld_sel),
        .ld_data(ld_data));

endmodule

//############################################
// Address decoder to write to the correct RAM
//############################################

module addr_dec (
	input [11:0] main_addr,
	input main_we,
	output [8:0] data_addr,
	output [5:0] out_addr, in_addr,
	output data_en, out_en, in_en
);

	assign data_addr = main_addr[10:2];
	assign  out_addr = main_addr[7:2];
	assign   in_addr = main_addr[7:2];

	assign data_en =                         (main_we && main_addr < 12'h800) ? 1 : 0;
	assign  out_en = (main_we && main_addr >= 12'h800 && main_addr < 12'h900) ? 1 : 0;
	assign   in_en = (main_we && main_addr >= 12'h900 && main_addr < 12'hA00) ? 0 : 1;

endmodule

//####################################
// Output mux to show the correct data
//####################################

module ld_mux (
	input [11:0] main_addr,
	input [31:0] mem_data, out_data, in_data,
	output [31:0] data_out
);

	assign data_out =       (main_addr < 12'h800) ? mem_data :
	(main_addr >= 12'h800 && main_addr < 12'h900) ? out_data :
	(main_addr >= 12'h900 && main_addr < 12'hA00) ?  in_data : 0;

endmodule

//############################################################
// A latch that takes equality of two numbers as enable signal
//############################################################

module latch32_cp (
    input [11:0] A, B,
    input [31:0] ins,
    output [31:0] outs
);

	assign outs = (A == B) ? ins : 0;

endmodule

//###############################################################
// A register that takes equality of two numbers as enable signal
//###############################################################

module reg32_cp (
    input clk, rstn, en,
    input [11:0] A, B,
	 input [3:0] byte_en,
    input [31:0] ins,
    output logic [31:0] outs
);

    always_ff @ (negedge clk, negedge rstn)
        if (!rstn) outs = 0;
        else if (en && A == B) begin
		      if (byte_en[0]) outs[ 7: 0] <= ins[ 7: 0];
				if (byte_en[1]) outs[15: 8] <= ins[15: 8];
				if (byte_en[2]) outs[23:16] <= ins[23:16];
				if (byte_en[3]) outs[31:24] <= ins[31:24];
		  end

endmodule

//###############################################################
// A multiplexer to support LB, LBU, LH, and LHU
//###############################################################

module ld_sel_mux (
	input [31:0] LW,
	input [7:0] LB, LBU,
	input [15:0] LH, LHU,
	input [2:0] ld_sel,
	output [31:0] ld_data
);

	assign ld_data = (ld_sel == 3'h0) ? {24'b0,LBU} :
	                 (ld_sel == 3'h1) ? {16'b0,LHU} :
					 (ld_sel == 3'h2 || ld_sel == 3'h3) ? {{24{LB[7]}},LB} :
					 (ld_sel == 3'h4 || ld_sel == 3'h5) ? {{16{LH[15]}},LH} :
					 (ld_sel == 3'h6) ? LW : LW;

endmodule