`timescale 1ps/1ps

module immGen_tb;

    logic  [31:0] instr;
    logic [31:0] imm;
	
	immGen dut (
    	.instr(instr),
		.imm(imm));
	
	initial begin
		instr     = 32'h0;
		$dumpfile("immGendump.vcd");
		$dumpvars;
	end
	
	initial begin
		#3;
		instr = 32'b00000000000000000100001010110111; //lui x5, 4 
	   #1	
		assert (imm == 32'h4000) $display("PASSED"); else $error("Assertion failed");
      #2
		instr = 32'b00000000000000001011001100010111; //auipc x6, 11
		#1
	   assert (imm == 32'hb000) $display("PASSED"); else $error("Assertion failed");
      #2
		instr = 32'b00000000100000000000010101101111; //jal x10, 8
		#1
	   assert (imm == 32'd8) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000110000110000000111100111; //jalr x3, 12(x6)
		#1
	   assert (imm == 32'd12) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000001001110100000011001100011; //beq x20, x19, 12
		#1
	   assert (imm == 32'd12) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000001001110100001010101100011; //bne x20, x19, 10
		#1
	   assert (imm == 32'd10) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000001001110100100001001100011; //blt x20, x19, 4
		#1
	   assert (imm == 32'd4) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000001001101111101001101100011; //bge x15, x19, 6
		#1
	   assert (imm == 32'd6) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000010100011110010001100011; // BLTU x3, x5, 8
		#1
	   assert (imm == 32'd8) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000001000001111111100001100011; // BGEU x15, x16, 16
		#1
		assert (imm == 32'd16) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000001100010000001010000011; //lb x5, 3(x2)
		#1
		assert (imm == 32'd3) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000001001111001001100000011; //lh x6, 2(x15)
		#1
		assert (imm == 32'd2) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000000101111100001100000011; //lbu x6, 1(x15)
		#1
		assert (imm == 32'd1) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000100001111101001100000011; //lhu x6, 8(x15)
		#1
		assert (imm == 32'd8) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000010011001111000001000100011; //sb x6, 36(x15)
		#1
		assert (imm == 32'd36) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000011001111001101000100011; //sh x6, 20(x15)
		#1
		assert (imm == 32'd20) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000000000110010101000000011; //LW x20, 0(x6)
		#1
		assert (imm == 32'd0) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000100100010010001000100011; //SW x9, 4(x2)
		#1
		assert (imm == 32'd4) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b11111111101110001000110100010011; //ADDI x26, x17, -5
		#1
		assert (imm == 32'b11111111111111111111111111111011) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b11111111101110001010110100010011; //SLTI x26, x17, -5
		#1
		assert (imm == 32'b11111111111111111111111111111011) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b11111111101110001011110100010011; //SLTIU x26, x17, -5
		#1
		assert (imm == 32'd4091) $display("PASSED"); else $error("Assertion failed"); //-5 in bin is considered in unsigned number
		#2
		instr = 32'b00000000010110001011110100010011; //SLTIU x26, x17, 5
		#1
		assert (imm == 32'd5) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000100110010100001010010011; //XORI x5, x18, 9
		#1
	   assert (imm == 32'd9) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000101101100110001010010011; //ORI x5, x12, 11
		#1
	   assert (imm == 32'd11) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b11111111110101001111001010010011; //ANDI x5, x9, -3
		#1
		assert (imm == 32'b11111111111111111111111111111101) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000011001001001001010010011; //SLLI x5, x9, 6
		#1
	   assert (imm == 32'd6) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000001101010101001010010011; //SRLI x5, x10, 3
		#1
		assert (imm == 32'd3) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b01000000110001010101010110010011; //SRAI x11, x10, 12
		#1
	   assert (imm == 32'd12) $display("PASSED"); else $error("Assertion failed");
		#2
		instr = 32'b00000000010101010000010110110011; //ADD x11, x10, x5
		#1
	   assert (imm == 32'd0) $display("PASSED"); else $error("Assertion failed");
		#9 $finish;
	end

endmodule 