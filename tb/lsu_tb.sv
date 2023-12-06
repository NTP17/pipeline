`timescale 1ps/1ps

module lsu_tb;

	logic clk_i, rst_ni, st_en;
	logic [11:0] addr;
   logic [3:0] byte_en;
	logic [31:0] st_data, io_sw;
	logic [31:0] ld_data, io_lcd, io_ledg, io_ledr, io_hex0, io_hex1, io_hex2, io_hex3, io_hex4, io_hex5, io_hex6, io_hex7;
	
	lsu dut (
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.st_en(st_en),
		.addr(addr),
		.st_data(st_data),
		.io_sw(io_sw),
		.byte_en(byte_en),
		.ld_data(ld_data),
		.io_lcd(io_lcd),
		.io_ledg(io_ledg),
		.io_ledr(io_ledr),
		.io_hex0(io_hex0),
		.io_hex1(io_hex1),
		.io_hex2(io_hex2),
	   .io_hex3(io_hex3),
		.io_hex4(io_hex4),
		.io_hex5(io_hex5),
		.io_hex6(io_hex6),
	   .io_hex7(io_hex7));
	
	initial begin
		rst_ni       = 1'b0;
      st_en        = 1'b1;
		byte_en      = 4'b1111;
		addr         = 12'h752;
		st_data      = 32'h13579bdf;
		io_sw        = 32'h3;
		$dumpfile("lsudump.vcd");
		$dumpvars;
	end
	
	initial begin
    clk_i = 1'b0;
	 forever #5 clk_i = !clk_i; //period 10ps
   end
	
	initial begin
		#10
		//check written data at 0x752
		assert (ld_data == 32'h13579bdf) $display("PASSED"); else $error("Assertion failed");
      rst_ni   = 1'b1; //written data in lsu does not depend on rst_ni
		#7
		assert (ld_data == 32'h13579bdf) $display("PASSED"); else $error("Assertion failed");
		#1 
      addr     = 12'h815;
		st_data  = 32'h89abcdef;
		#10
		//check written data at 0x815
		assert (ld_data == 32'h89abcdef) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h8A0;
		#10
		//check io_lcd
		assert (io_lcd == 32'h89abcdef) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h900;
		#10
		st_data  = 32'h01234567;
		addr     = 12'h7ab;
		#10
		//check written data at 0x7ab
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		st_en    = 1'b0; //read mode
		#10
		addr     = 12'h752;
		#10
		addr     = 12'h815;
		#10
		addr     = 12'h900;
		#10
		//check loaded data at 0x900 - sw data
		assert (ld_data == 32'h03) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h800;
		st_en    = 1'b1;
		#10
		//check written data at 0x800
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_hex0
		assert (io_hex0 == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h810;
		#10
		//check written data at 0x810
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_hex1
		assert (io_hex1 == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h820;
		#10
		//check written data at 0x820
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_hex2
		assert (io_hex2 == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h830;
		#10
		//check written data at 0x830
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_hex3
		assert (io_hex3 == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h840;
		#10
		//check written data at 0x840
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_hex0
		assert (io_hex4 == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h850;
		#10
		//check written data at 0x850
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_hex0
		assert (io_hex5 == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h860;
		#10
		//check written data at 0x860
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_hex0
		assert (io_hex6 == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h870;
		#10
		//check written data at 0x870
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_hex7
		assert (io_hex7 == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h880;
		#10
		//check written data at 0x880
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_ledr
		assert (io_ledr == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h890;
		#10
		//check written data at 0x890
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_ledg
		assert (io_ledg == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		addr     = 12'h8A0;
		#10
		//check written data at 0x8a0
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		//check io_lcd
		assert (io_lcd == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		st_en    = 1'b0; //read mode
		addr     = 12'h752;
		#10
		st_en    = 1'b1; //write mode
		#10
		//check written data at 0x752 since current st_data is 32'h01234567
		assert (ld_data == 32'h01234567) $display("PASSED"); else $error("Assertion failed");
		io_sw    = 32'h5;
		addr     = 12'h912;
		#10
		st_data  = 32'h246;
		addr     = 12'h7ab;
		#10
		//check written data at 0x7ab
	   assert (ld_data == 32'h246) $display("PASSED"); else $error("Assertion failed");
		st_data  = 32'h1;
		#10
	   //check written data at 0x7ab
	   assert (ld_data == 32'h1) $display("PASSED"); else $error("Assertion failed");
		rst_ni   = 1'b0; //reset
		#10
		assert (io_hex0 == 32'h0) $display("PASSED"); else $error("Assertion failed");
	   assert (io_hex1 == 32'h0) $display("PASSED"); else $error("Assertion failed");
		assert (io_hex2 == 32'h0) $display("PASSED"); else $error("Assertion failed");
		assert (io_hex3 == 32'h0) $display("PASSED"); else $error("Assertion failed");
		assert (io_hex4 == 32'h0) $display("PASSED"); else $error("Assertion failed");
		assert (io_hex5 == 32'h0) $display("PASSED"); else $error("Assertion failed");
		assert (io_hex6 == 32'h0) $display("PASSED"); else $error("Assertion failed");
		assert (io_hex7 == 32'h0) $display("PASSED"); else $error("Assertion failed");
		assert (io_lcd == 32'h0) $display("PASSED"); else $error("Assertion failed");
		assert (io_ledg == 32'h0) $display("PASSED"); else $error("Assertion failed");
		assert (io_ledr == 32'h0) $display("PASSED"); else $error("Assertion failed");
		#10
		rst_ni   = 1'b1;
		st_data   = 32'h13579bdf;
		addr      = 12'h810;
		byte_en   = 4'b1111;
		#10
	   assert (io_hex1 == 32'h13579bdf) $display("PASSED"); else $error("Assertion failed");
		#10
	   byte_en   = 4'b0011;
		#10
	   byte_en   = 4'b0001;
		#10	$finish;
	end

endmodule 
