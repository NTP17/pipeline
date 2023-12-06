`timescale 1ps/1ps

module regfile_tb;

	logic [31:0] rd_data;
	logic clk_i, rst_ni, rd_wren;
   logic [4:0] rs1_addr, rs2_addr, rd_addr; 
   logic [31:0] rs1_data, rs2_data;
	
	regfile dut (
    	.rd_data(rd_data),
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.rd_wren(rd_wren),
		.rs1_addr(rs1_addr),
		.rs2_addr(rs2_addr),
		.rd_addr(rd_addr),
		.rs1_data(rs1_data),
		.rs2_data(rs2_data));
	
	initial begin
		rst_ni       = 1'b1;
		rs1_addr     = 5'd1;
		rs2_addr     = 5'd2;
		rd_addr      = 5'd0;  
      rd_wren      = 1'b0;
		rd_data      = 32'h13579bdf;
		$dumpfile("regdump.vcd");
		$dumpvars;
	end
	
	initial begin
    clk_i = 1'b0;
	 forever #5 clk_i = !clk_i;
   end
	
	initial begin
		#5
      rst_ni   = 1'b1;
		#2
		rd_wren  = 1'b1;
		#10
		rs1_addr = 5'd3;
		rs2_addr = 5'd4;
		#10
		rd_addr  = 5'd3;
		#10 
		//rs1_data updated
		assert (rs1_data == 32'h13579bdf) $display("PASSED"); else $error("Assertion failed");
		rd_data  = 32'h1;
		rd_addr  = 5'd4;
		#10
		//rs2_data updated
		assert (rs2_data == 32'h1) $display("PASSED"); else $error("Assertion failed");
		rd_data  = 32'hffff1357;
		#10
		//rs2_data updated and rs1_data unchanged
		assert (rs2_data == 32'hffff1357) $display("PASSED"); else $error("Assertion failed");
		assert (rs1_data == 32'h13579bdf) $display("PASSED"); else $error("Assertion failed");
		rd_wren  = 1'b0;
		rd_addr  = 5'd3;
		#10
		//rs1_data and rs2_data unchanged
		assert (rs2_data == 32'hffff1357) $display("PASSED"); else $error("Assertion failed");
		assert (rs1_data != rs2_data) $display("PASSED"); else $error("Assertion failed");
		rd_wren  = 1'b1;
		#10
		//rs1_data updated and equals to rs2_data
	   assert (rs1_data == 32'hffff1357) $display("PASSED"); else $error("Assertion failed");
		assert (rs1_data == rs2_data) $display("PASSED"); else $error("Assertion failed");
		rd_addr  = 5'd8;
		rd_data  = 32'h246;
		#10
		rs1_addr = 5'd8;
		#1
		//rs1_data changed immediately
		assert (rs1_data == 32'h00000246) $display("PASSED"); else $error("Assertion failed");
		#9
		rd_data  = 32'h1317131f;
		#10
		//rs1_data updated
		assert (rs1_data == 32'h1317131f) $display("PASSED"); else $error("Assertion failed");
		rs2_addr = 5'd12;
		#10
      rd_addr  = 5'd12;
		#10
		//rs2_data updated
		assert (rs2_data == 32'h1317131f) $display("PASSED"); else $error("Assertion failed");
		rst_ni  = 1'b0;
		#1
		//rs1_data and rs2_data are cleared
	   assert (rs1_data == 32'h0) $display("PASSED"); else $error("Assertion failed");
		assert (rs2_data == 32'h0) $display("PASSED"); else $error("Assertion failed");
		rst_ni  = 1'b1;
		#8
		//rs2_data updated again
		assert (rs2_data == 32'h1317131f) $display("PASSED"); else $error("Assertion failed");
	   #1	$finish;
	end

endmodule 