module clock_divider (
	input clkin, reset,
	output clkout
);

	reg [2:0] count;

	always_ff @ (posedge clkin, negedge reset)
	if (!reset) begin
		clkout <= 0;
		count <= 0;
	end
	else if (count == 3'd4) begin
		clkout <= 1;
		count <= 0;
	end
	else begin
		clkout <= 0;
		count <= count + 1;
	end

endmodule
