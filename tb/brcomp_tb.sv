`timescale 1ps/1ps

module brcomp_tb;

	logic [31:0] rs1_data, rs2_data;
	logic br_unsigned;
	logic br_less, br_equal;
	
	brcomp dut (
    	.rs1_data(rs1_data),
		.rs2_data(rs2_data),
		.br_unsigned(br_unsigned),
		.br_less(br_less),
		.br_equal(br_equal));
	
	initial begin
		rs1_data     = 32'h0;
		rs2_data     = 32'h0;  
		br_unsigned  =  1'b0;
		$dumpfile("vendump.vcd");
		$dumpvars;
	end
	
	initial begin
		#5;
		rs1_data  =  32'h12345678;
		rs2_data  =  32'h01234567;  
		#1
		assert (br_less == 1'b0) $display("PASSED"); else $error("Assertion failed");
	   assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
		#4
		br_unsigned     =  1'b1;
		#1
		assert (br_less == 1'b0) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
		#4
		rs1_data  =  32'h01234567;
		rs2_data  =  32'h12345678;
		#1
		assert (br_less == 1'b1) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
		#4
		br_unsigned     =  1'b0;
		#1
		assert (br_less == 1'b1) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
      #4
		rs1_data  =  32'h01234567;
		rs2_data  =  32'h89abcdef;
		#1
		assert (br_less == 1'b0) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
		#4
		br_unsigned     =  1'b1;
		#1
		assert (br_less == 1'b1) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
		#4
		rs1_data  =  32'h89abcdef;
		rs2_data  =  32'h01234567;
		#1
		assert (br_less == 1'b0) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
		#4
		br_unsigned     =  1'b0;
		#1
		assert (br_less == 1'b1) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");		
		#4
		rs1_data  =  32'h89abcdef;
		rs2_data  =  32'h87654321;
		#1
		assert (br_less == 1'b0) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
		#4
		br_unsigned     =  1'b1;	
		#1
		assert (br_less == 1'b0) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
		#4
	   rs1_data  =  32'h87654321;
		rs2_data  =  32'h89abcdef;
		#1
		assert (br_less == 1'b1) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
		#4
		br_unsigned     =  1'b0;
		#1
		assert (br_less == 1'b1) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b0) $display("PASSED"); else $error("Assertion failed");
		#4
	   rs1_data  =  32'h01234567;
		rs2_data  =  32'h01234567;
		#1
		assert (br_less == 1'b0) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b1) $display("PASSED"); else $error("Assertion failed");
		#4
		br_unsigned     =  1'b1;
		#1
		assert (br_less == 1'b0) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b1) $display("PASSED"); else $error("Assertion failed");
		#4
	   rs1_data  =  32'h89abcdef;
		rs2_data  =  32'h89abcdef;
		#1
		assert (br_less == 1'b0) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b1) $display("PASSED"); else $error("Assertion failed");
		#4
		br_unsigned     =  1'b0;
		#1
		assert (br_less == 1'b0) $display("PASSED"); else $error("Assertion failed");
		assert (br_equal == 1'b1) $display("PASSED"); else $error("Assertion failed");
		#9 $finish;
	end

endmodule 