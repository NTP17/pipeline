`timescale 1ps/1ps

module ctrl_unit_tb;

    logic [31:0] instr;
    logic br_less, br_equal;
    logic br_sel, rd_wren, br_unsigned, op_a_sel, op_b_sel, mem_wren;
    logic [3:0] alu_op, byte_en;
    logic [1:0] wb_sel;
	 logic [2:0] ld_sel;
	
	ctrl_unit dut (
		.instr(instr),
		.br_less(br_less),
		.br_equal(br_equal),
		.br_sel(br_sel),
		.rd_wren(rd_wren),
		.br_unsigned(br_unsigned),
		.op_a_sel(op_a_sel),
		.op_b_sel(op_b_sel),
		.mem_wren(mem_wren),
		.alu_op(alu_op),
		.byte_en(byte_en),
		.wb_sel(wb_sel),
		.ld_sel(ld_sel));
	
	initial begin
		instr        = 32'b0;
      br_less      = 1'b0;
		br_equal     = 1'b0;
		$dumpfile("ctrlunitdump.vcd");
		$dumpvars;
	end
	
	initial begin
		#3
		instr = 32'b00000000000000000111010100110111; // LUI x10, 7
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && 
		(byte_en == 4'b0) && (wb_sel == 2'b0) && (ld_sel == 3'b0)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		br_less = 1'b0; //test 4 cases when br_less and br_equal are "don't care"
		br_equal = 1'b1;
		#3
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		instr = 32'b00000000000000000111010100010111; // AUIPC x10, 7
		#1
      assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		br_equal = 1'b1; //test 4 cases when br_less and br_equal are "don't care"
		#3
		br_less = 1'b0;
		#3
		br_equal = 1'b0;
		#3 
		instr = 32'b00000000101000000000001011101111; // JAL x5, 10
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b10)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		br_equal = 1'b1; //test 4 cases when br_less and br_equal are "don't care"
		#3
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		instr = 32'b0000000000011000010101100111; // JALR x5, 0(x2)
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) && 
		(wb_sel == 2'b10)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		br_equal = 1'b1; //test 4 cases when br_less and br_equal are "don't care"
		#3
		br_less = 1'b0;
		#3
		br_equal = 1'b0;
		#3
		instr = 32'b00000000101001011000010001100011; // BEQ x11, x10, 8
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) && 
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 0, br_equal = 0
		#2
		br_equal = 1'b1; 
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 0, br_equal = 1
      #2
		instr = 32'b00000000101001011001011001100011; // BNE x11, x10, 12
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 0, br_equal = 1
		#2
		br_equal = 1'b0; 
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 0, br_equal = 0
		#2
		instr = 32'b00000001000001111100010001100011; // BLT x15, x16, 8
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 0, br_equal = 0
		#2
		br_less = 1'b1;
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 1, br_equal = 0
		#2
		instr = 32'b00000000110000111101001001100011; // BGE x7, x12, 4
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 1, br_equal = 0
		#2
		br_less = 1'b0; //br_less = 0, br_equal = 0
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 0, br_equal = 0
		#2
		br_equal = 1'b1;
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 0, br_equal = 1
		#2
		instr = 32'b00000000010100011110010001100011; // BLTU x3, x5, 8
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 0, br_equal = 1
		#2
		br_less = 1'b1;
		br_equal = 1'b0;
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 1, br_equal = 0
		#2
		instr = 32'b00000001000001111111100001100011; // BGEU x15, x16, 16
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 1, br_equal = 0
		#2
		br_less = 1'b0;
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 0, br_equal = 0
		#2
		br_equal = 1'b1; 
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //br_less = 0, br_equal = 1
		#2
		instr = 32'b00000000000000110010101000000011; //LW x20, 0(x6)
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b110) &&
		(wb_sel == 2'b01)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000100000011000010000000011; //LB x8, 8(x3)
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b010) &&
		(wb_sel == 2'b01)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		instr = 32'b00000000001000011001010000000011; //LH x8, 2(x3)
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b100) &&
		(wb_sel == 2'b01)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		instr = 32'b00000000000100011100010000000011; //LBU x8, 1(x3)
		#1 
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b01)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		instr = 32'b00000000000000011101010000000011; //LHU x8, 0(x3)
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b1) &&
		(wb_sel == 2'b01)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		instr = 32'b00000000100100010010001000100011; //SW x9, 4(x2)
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b1) && (alu_op == 4'b0) && (byte_en == 4'b1111) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000101000011000010110100011; //SB x10, 11(x3)
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b1) && (alu_op == 4'b0) && (byte_en == 4'b1) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		instr = 32'b00000000101000011001010100100011; //SH x10, 10(x3)
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b1) && (alu_op == 4'b0) && (byte_en == 4'b011) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		instr = 32'b11111111101110001000110100010011; //ADDI x26, x17, -5
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b11111111101110001010110100010011; //SLTI x26, x17, -5
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b10) && (byte_en == 4'b0) && (ld_sel == 3'b0) && 
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b11111111101110001011110100010011; //SLTIU x26, x17, -5
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b011) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000100110010100001010010011; //XORI x5, x18, 9
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b100) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000101101100110001010010011; //ORI x5, x12, 11
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b101) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b11111111110101001111001010010011; //ANDI x5, x9, -3
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b110) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
	   #2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011001001001001010010011; //SLLI x5, x9, 6
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b111) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000001101010101001010010011; //SRLI x5, x10, 3
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b1000) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b01000000110001010101010110010011; //SRAI x11, x10, 12
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b1001) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000010101010000010110110011; //ADD x11, x10, x5
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b01000000010101010000010110110011; //SUB x11, x10, x5
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b1) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011100110010001010110011; //SLT x5, x6, x7
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b10) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011100110011001010110011; //SLTU x5, x6, x7
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b011) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011100110100001010110011; //XOR x5, x6, x7
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b100) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3         
		instr = 32'b00000000011100110110001010110011; //OR x5, x6, x7
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b101) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011100110111001010110011; //AND x5, x6, x7
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b110) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3          
		instr = 32'b00000000011100110001001010110011; //SLL x5, x6, x7
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b111) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011100110101001010110011; //SRL x5, x6, x7
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b1000) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3          
		instr = 32'b01000000011100110101001010110011; //SRA x5, x6, x7
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b1001) && (byte_en == 4'b0) && (ld_sel == 3'b0) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed"); //test 4 cases when br_less and br_equal are "don't care"
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
	   #10	$finish;
	end

endmodule 