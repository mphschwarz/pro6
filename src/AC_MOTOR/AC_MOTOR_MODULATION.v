module AC_MOTOR_MODULATION(
	input CLK,
	input MODULATION,
	input S_TRIANGLE,
	input S_VECTOR,
	output reg S_OUT
);

initial begin
	S_OUT <= 0;
end

always @(posedge CLK) begin
	if (MODULATION == 1) begin
		S_OUT <= S_VECTOR;
	end else begin
		S_OUT <= S_TRIANGLE;
	end
end

endmodule
