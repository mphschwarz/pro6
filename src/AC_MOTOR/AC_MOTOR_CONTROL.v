module AC_MOTOR_CONTROL(
	input CLK,
	input [resolution_bits - 1:0] POWER,
	input [15:0] MOD_DELAY_UMIN,
	output reg MODULATION,
	output reg [10:0] DELAY,
	output reg [resolution_bits - 1:0] FREQUENCY,
	output reg [resolution_bits - 1:0] AMPLITUDE
	);

	parameter resolution_bits = 12;
	parameter delay_min = 1000;

	reg [11:0] power;
	reg [10:0] delay;
	reg [6:0] u_min;
	reg modulation;

	initial begin
		//power <= 2**10 - 1;
		power <= 0;
		AMPLITUDE <= 0;
		FREQUENCY <= 0;
		modulation <= 1;
		MODULATION <= 1; //set to Vector modulation (default)
		delay <= 2**19 - 1;
		DELAY <= 2**19 - 1; //set to max value for safety
		u_min <= 0;
	end

	always @(posedge CLK) begin
		power <= POWER;
		modulation <= MOD_DELAY_UMIN[15];
		u_min <= MOD_DELAY_UMIN[7:1];
		delay <= MOD_DELAY_UMIN[14:8];
	end

	always @(posedge CLK) begin
		//Amplitude forced to minimal Value if below
		if (power < u_min) AMPLITUDE <= u_min;
		else AMPLITUDE <= power;
		FREQUENCY <= 2**12 - 1 - power;

		DELAY <= delay_min + delay;
		MODULATION <= modulation;
	end

endmodule
