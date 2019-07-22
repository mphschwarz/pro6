module AC_MOTOR_COMPARATOR(
	input CLK,

	input signed [bits + level_bits - 1:0] TRIANGLE,
	input signed [bits + level_bits - 1:0] SINE,

	output reg OUT
);

parameter bits = 12;
parameter level_bits = 12;

initial begin
	OUT <= 0;
end

always @(posedge CLK) begin
	if (SINE > TRIANGLE) OUT <= 1;
	else OUT <= 0;
end

endmodule
