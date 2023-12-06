module reg_execute_memory (
    input         mem_wrenE, rd_wrenE,
    input  [1:0]  wb_selE,
    input  [2:0]  ld_selE,
    input  [3:0]  byte_enE,
    input  [4:0]  rd_addrE,
    input  [12:0] pc4E,
    input  [31:0] alu_dataE, rs1_dataE, rs2_dataE, forward2outE,

    input         clk, aclr,

    output logic        mem_wrenM, rd_wrenM,
    output logic [1:0]  wb_selM,
    output logic [2:0]  ld_selM,
    output logic [3:0]  byte_enM,
    output logic [4:0]  rd_addrM,
    output logic [12:0] pc4M,
    output logic [31:0] alu_dataM, rs1_dataM, rs2_dataM, forward2outM
);

    always_ff @ (posedge clk, negedge aclr)
    if (!aclr) {wb_selM, ld_selM, mem_wrenM, byte_enM, rd_wrenM, alu_dataM, forward2outM, rs2_dataM, rs1_dataM, rd_addrM, pc4M} = 'b0;
    else       {wb_selM, ld_selM, mem_wrenM, byte_enM, rd_wrenM, alu_dataM, forward2outM, rs2_dataM, rs1_dataM, rd_addrM, pc4M} = {wb_selE, ld_selE, mem_wrenE, byte_enE, rd_wrenE, alu_dataE, forward2outE, rs2_dataE, rs1_dataE, rd_addrE, pc4E};

endmodule