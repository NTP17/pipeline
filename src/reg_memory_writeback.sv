module reg_memory_writeback (
    input         rd_wrenM,
    input  [1:0]  wb_selM,
    input  [4:0]  rd_addrM,
    input  [12:0] pc4M,
    input  [31:0] alu_dataM, ld_dataM,

    input         clk, aclr,

    output logic        rd_wrenW,
    output logic [1:0]  wb_selW,
    output logic [4:0]  rd_addrW,
    output logic [12:0] pc4W,
    output logic [31:0] alu_dataW, ld_dataW
);

    always_ff @ (posedge clk, negedge aclr)
    if (!aclr) {wb_selW, rd_wrenW, alu_dataW, ld_dataW, rd_addrW, pc4W} = 'b0;
    else       {wb_selW, rd_wrenW, alu_dataW, ld_dataW, rd_addrW, pc4W} = {wb_selM, rd_wrenM, alu_dataM, ld_dataM, rd_addrM, pc4M};

endmodule