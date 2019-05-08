module AC_MOTOR_CONTROL(
	input CLK,
	input [resolution_bits - 1:0] POWER,
	output reg [resolution_bits - 1:0] FREQUENCY,
	output reg signed [resolution_bits - 1:0] AMPLITUDE
	//output reg CW,
	//output reg CCW
	);

	parameter resolution_bits = 12;

	reg [12:0] power_int;

	initial begin
		power_int <= 2**10 - 1;
	end

	// always @(posedge CLK) begin
	// 	power_int <= POWER;
	// end

	always @(posedge CLK) begin
		AMPLITUDE <= power_int;
		FREQUENCY <= 2**12 - 1 - power_int;
		//CW <= 0;
		//CCW <= 1;
	end


endmodule
