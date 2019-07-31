module AC_MOTOR_CONTROL(
	input CLK,
	input [resolution_bits - 1:0] POWER, // bit 15: modulation
	                                     // bit 14:8 delay
	                                     // bit 7:0 UMin
	input [15:0] MOD_DELAY_UMIN, 
	output reg MODULATION,
	output reg [10:0] DELAY,
	output reg [resolution_bits - 1:0] FREQUENCY,
	output reg [resolution_bits - 1:0] AMPLITUDE
	);

	parameter resolution_bits = 12;
	parameter f_clk = 100; // in MHz
	parameter delay_min_s = 300; // in ns
	parameter delay_min = f_clk * delay_min_s / 2000;

	reg [11:0] power;
	reg [10:0] delay;
	reg [6:0] u_min;
	reg modulation;

	initial begin
		power <= 0;
		AMPLITUDE <= 0;
		FREQUENCY <= 2**12 - 1;
		modulation <= 1; //set to Vector modulation (default)
		MODULATION <= 1; //set to Vector modulation (default)
		delay <= 2**19 - 1;
		DELAY <= 2**19 - 1; //set to max value for safety
		u_min <= 0;
	end

	always @(posedge CLK) begin //update internal values
		power <= POWER;
		modulation <= MOD_DELAY_UMIN[15];
		u_min <= MOD_DELAY_UMIN[7:1];
		delay <= MOD_DELAY_UMIN[14:8];
	end

	always @(posedge CLK) begin
		//Amplitude forced to minimal Value if below
		//if (power < u_min) AMPLITUDE <= u_min; 
		//else AMPLITUDE <= power;
		AMPLITUDE <= 2**12 - 1;

		FREQUENCY <= 0; // FREQUENCY <= 2**12 - 1 - power;
		DELAY <= delay_min; // DELAY <= delay_min + delay;
		MODULATION <= 1; //MODULATION <= modulation;
	end

endmodule
