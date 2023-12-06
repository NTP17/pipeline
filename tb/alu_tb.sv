`timescale 1ps/1ps

module alu_tb;

	logic [31:0] operand_a, operand_b;
	logic [3:0]  alu_op;
	logic [31:0] alu_data;
	alu dut (
    	.operand_a(operand_a),
		.operand_b(operand_b),
		.alu_op(alu_op),
		.alu_data(alu_data));
	
	initial begin
		operand_a  = 32'h0;
		operand_b  = 32'h0;  
		alu_op     =  4'ha;
		$dumpfile("vendump.vcd");
		$dumpvars;
	end
	
	initial begin
		#2;
		operand_a  =  32'h12345678;
		operand_b  =  32'h01234567;  
		alu_op     =  4'hb;
		#1
	   assert (alu_data == 32'h0) $display("PASSED"); else $error("Assertion failed");
		#1
		alu_op     =  4'hc;
		#2
		alu_op     =  4'hd;
		#2
		alu_op     =  4'he;
		#2
		alu_op     =  4'hf;
		#2
		alu_op     =  4'h0;
		#1
	   assert (alu_data == 32'h13579bdf) $display("PASSED"); else $error("Assertion failed");
		#4
		operand_a  =  32'h01234567;
		operand_b  =  32'h12345678;
		#3
	   assert (alu_data == 32'h13579bdf) $display("PASSED"); else $error("Assertion failed");
      #2
		operand_a  =  32'h01234567;
		operand_b  =  32'h89abcdef;
		#3
		assert (alu_data == 32'h8acf1356) $display("PASSED"); else $error("Assertion failed");
		#2
		alu_op     =  4'h1;
		#1
		assert (alu_data == 32'h77777778) $display("PASSED"); else $error("Assertion failed");
		#4
		alu_op     =  4'h2;
		#1
		assert (alu_data == 32'h0) $display("PASSED"); else $error("Assertion failed");
		#4
		alu_op     =  4'h3;
		#2
		assert (alu_data == 32'h1) $display("PASSED"); else $error("Assertion failed");
		#3
		operand_a  =  32'h89abcdef;
		operand_b  =  32'h01234567;
		#2
		assert (alu_data == 32'h0) $display("PASSED"); else $error("Assertion failed");
		#3
		alu_op     =  4'h2;
		#3
		assert (alu_data == 32'h1) $display("PASSED"); else $error("Assertion failed");
		#2
	   operand_a  =  32'h01234567;
		operand_b  =  32'h01234567;
		#1
	   assert (alu_data == 32'h0) $display("PASSED"); else $error("Assertion failed");
		#4
		operand_a  =  32'h89abcdef;
		operand_b  =  32'h87654321;
		#3
	   assert (alu_data == 32'h0) $display("PASSED"); else $error("Assertion failed");
		#2
		alu_op     =  4'h3;
		#1
		assert (alu_data == 32'h0) $display("PASSED"); else $error("Assertion failed");
		#4
	   operand_a  =  32'h87654321;
		operand_b  =  32'h89abcdef;
		#4
		assert (alu_data == 32'h1) $display("PASSED"); else $error("Assertion failed");
		#1
		alu_op     =  4'h2;
		#4
		assert (alu_data == 32'h1) $display("PASSED"); else $error("Assertion failed");
		#1
		alu_op     =  4'h4;
		#4
	   assert (alu_data == 32'h0ece8ece) $display("PASSED"); else $error("Assertion failed");
		#1
		operand_a  =  32'h12345678;
		operand_b  =  32'h01234567;
		#4
		assert (alu_data == 32'h1317131f) $display("PASSED"); else $error("Assertion failed");
		#1
		alu_op     =  4'h5;
		#4
		assert (alu_data == 32'h1337577f) $display("PASSED"); else $error("Assertion failed");
		#1
		alu_op     =  4'h6;
		#4
		assert (alu_data == 32'h00204460) $display("PASSED"); else $error("Assertion failed");
		#1
		alu_op     =  4'h7;
		#4
		assert (alu_data == 32'h1a2b3c00) $display("PASSED"); else $error("Assertion failed");
		#1
	   operand_a  =  32'h01234567;
		operand_b  =  32'h12345678;
		#3
	   assert (alu_data == 32'h67000000) $display("PASSED"); else $error("Assertion failed");
		#2
	   operand_a  =  32'h89abcdef;
		operand_b  =  32'h01234567;
		#3
	   assert (alu_data == 32'hd5e6f780) $display("PASSED"); else $error("Assertion failed");
		#2
		alu_op     =  4'h8;
		#4
		assert (alu_data == 32'h0113579b) $display("PASSED"); else $error("Assertion failed");
		#1
	   operand_a  =  32'h89abcdef;
		operand_b  =  32'h89abcdef;
		#2
		assert (alu_data == 32'h00011357) $display("PASSED"); else $error("Assertion failed");
		#3
		alu_op     =  4'h9;
		#4
		assert (alu_data == 32'hffff1357) $display("PASSED"); else $error("Assertion failed");
		#1
	   operand_a  =  32'h01234567;
		operand_b  =  32'h89abcdef;
		#10
		assert (alu_data == 32'h00000246) $display("PASSED"); else $error("Assertion failed");
		#10 $finish;
	end

endmodule 