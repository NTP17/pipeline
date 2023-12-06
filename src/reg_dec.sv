module reg_dec (
    input  [31:0] instr,
    output logic [4:0] rs1_addr, rs2_addr, rd_addr
);

    logic [4:0] rs1, rs2, rd;
    logic [6:0] opcode;

    assign rs2 = instr[24:20];
    assign rs1 = instr[19:15];
    assign rd  = instr[11:7];
    assign opcode = instr[6:0];

    localparam LUI = 7'b0110111;

    always_comb
        if (opcode == LUI)
        begin
            rs1_addr = 0;
            rs2_addr = rs2;
            rd_addr  = rd;
        end
        else
        begin
            rs1_addr = rs1;
            rs2_addr = rs2;
            rd_addr  = rd;
        end

endmodule