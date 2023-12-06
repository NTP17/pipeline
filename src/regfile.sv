module regfile (
    input wire clk_i,
    input wire rst_ni,
    input wire [4:0] rs1_addr,
    input wire [4:0] rs2_addr,
    input wire [4:0] rd_addr,
    input wire [31:0] rd_data,
    input wire rd_wren,
    output wire [31:0] rs1_data,
    output wire [31:0] rs2_data
);

    reg [31:0] registers [0:31];

    always @(negedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            for (int i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'h00000000;
            end
        end else if (rd_wren && rd_addr != 0) begin
            registers[rd_addr] <= rd_data;
        end
    end

    assign rs1_data = registers[rs1_addr];
    assign rs2_data = registers[rs2_addr];

endmodule
