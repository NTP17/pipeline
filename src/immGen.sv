module immGen (
    input  [31:0] instr,
    output logic [31:0] imm
);

    logic [19:0] iU;
    logic [20:0] iJ;
    logic [11:0] iI, iS;
    logic [12:0] iB;
    logic [4:0] shamt;
    logic [6:0] opcode;
    logic [2:0] funct3;

    assign iU = instr[31:12];
    assign iJ = {instr[31],instr[19:12],instr[20],instr[30:21],1'b0};
    assign iI = instr[31:20];
    assign iS = {instr[31:25],instr[11:7]};
    assign iB = {instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
    assign shamt = instr[24:20];
    assign opcode = instr[6:0];
    assign funct3 = instr[14:12];

    localparam LUI   = 7'b0110111;
    localparam AUIPC = 7'b0010111;
    localparam JAL   = 7'b1101111;
    localparam JALR  = 7'b1100111;
    localparam Br    = 7'b1100011;
    localparam Ld    = 7'b0000011;
    localparam St    = 7'b0100011;
    localparam Im    = 7'b0010011;

    always_comb
             if (opcode == LUI || opcode == AUIPC)                        imm = {iU,12'b0};
        else if (opcode == JAL)                                           imm = {{11{iJ[20]}},iJ};
        else if (opcode == JALR || opcode == Ld ||
                (opcode == Im && (funct3 == 3'b000 || funct3 == 3'b010 ||
                                  funct3 == 3'b100 || funct3 == 3'b110 ||
                                  funct3 == 3'b111)))                     imm = {{20{iI[11]}},iI};
        else if (opcode == Im &&  funct3 == 3'b011)                       imm = {20'b0, iI};
        else if (opcode == Im && (funct3 == 3'b001 || funct3 == 3'b101))  imm = {27'b0,shamt};
        else if (opcode == Br)                                            imm = {{19{iB[12]}},iB};
        else if (opcode == St)                                            imm = {{20{iS[11]}},iS};
		  else                                                              imm = 0;

endmodule