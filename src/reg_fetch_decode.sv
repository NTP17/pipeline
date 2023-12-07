module reg_fetch_decode (
    input  [31:0] instrF,
    input  [12:0] pcF, pc4F,

    input         clk, sclr, aclr, en,

    output logic [31:0] instrD,
    output logic [12:0] pcD, pc4D
);

    always_ff @ (posedge clk, negedge aclr)
    if (!aclr) begin
        instrD = 0;
        pcD    = 0;
        pc4D   = 0;
    end else if (sclr) begin
        instrD = 0;
        pcD    = 0;
        pc4D   = 0;
    end else if (en) begin
        instrD = instrF;
        pcD    = pcF;
        pc4D   = pc4F;
    end

endmodule