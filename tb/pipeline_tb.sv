`timescale 1ps/1ps

module pipeline_tb;

    logic clk_i, rst_ni;
    logic [31:0] io_sw_i;
    //logic [12:0] pc_debug_o;
    logic [31:0] io_lcd_o, io_ledg_o, io_ledr_o, io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o, io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o;
	
	pipeline dut (
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.io_sw_i(io_sw_i),
		//.pc_debug_o(pc_debug_o),
		.io_lcd_o(io_lcd_o),
		.io_ledg_o(io_ledg_o),
		.io_ledr_o(io_ledr_o),
		.io_hex0_o(io_hex0_o),
		.io_hex1_o(io_hex1_o),
		.io_hex2_o(io_hex2_o),
	   .io_hex3_o(io_hex3_o),
		.io_hex4_o(io_hex4_o),
		.io_hex5_o(io_hex5_o),
		.io_hex6_o(io_hex6_o),
	   .io_hex7_o(io_hex7_o));
	
	initial begin
		rst_ni       = 1'b0;
		$dumpfile("pipelinedump.vcd");
		$dumpvars;
	end
	
	initial begin
    clk_i = 1'b0;
	 forever #1 clk_i = !clk_i;
   end
	
	initial begin
		#1
      rst_ni   = 1'b1;
      
		//rs1_data updated
		//assert (rs1_data == 32'h13579bdf) $display("PASSED"); else $error("Assertion failed");

	   #2000	$finish;
		
	end
	   

endmodule 