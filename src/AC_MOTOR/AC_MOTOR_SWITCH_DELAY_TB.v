`include "../AC_MOTOR_VECTOR/AC_MOTOR_SINE_SECTOR.v"
`include "../AC_MOTOR_VECTOR/AC_MOTOR_VECTOR_TIME.v"
`include "../AC_MOTOR_VECTOR/AC_MOTOR_VECTOR_CONTROL.v"
`include "../AC_MOTOR_VECTOR/AC_MOTOR_SWITCH_CONTROL.v"
`include "AC_MOTOR_SWITCH_DELAY.v"
`include "AC_MOTOR_CONTROL.v"
`timescale 10ns/1ns // for testing with python (Memory issues)
//`timescale 1ns/100ps // for accurate timing testing (actual frequency)


module AC_MOTOR_SWITCH_DELAY_TB;
	integer file;
	reg clk;
	reg [11:0] power;
	reg [15:0] mod_delay_umin;
	reg enable;
	wire [11:0] frequency;
	wire [11:0] u_str;
	wire [10:0] delay;
	wire [2:0] sector_unsynced;
	wire [2:0] sector_synced;
	wire [12-1:0] sine_pos;
	wire [12-1:0] sine_neg;
	wire [14:0] t0;
	wire [14:0] t1;
	wire [14:0] t2;
	wire [14:0] t7;
	wire u0;
	wire u1;
	wire u2;
	wire u7;
	wire s1;
	wire s2;
	wire s3;
	wire s1_high;
	wire s1_low;
	wire s2_high;
	wire s2_low;
	wire s3_high;
	wire s3_low;

	reg last_s_1_high;
	reg last_s_1_low;
	reg last_s_2_high;
	reg last_s_2_low;
	reg last_s_3_high;
	reg last_s_3_low;

	reg short_error;

	initial begin
		$dumpfile("vcd/ac_motor_switch_delay_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_SWITCH_DELAY_TB); 

		clk <= 1;
		power <= 2**12 - 1;
		mod_delay_umin <= 16'b1000000000000000;
		enable <= 1;
		//frequency <= 2**12-1;
		//frequency <= 0;
		// u_str <= 2**12 - 1;
		// delay <= 500;
		//#625000 delay <= 1000;
		//#625000 delay <= 2000;
		//#1250000 $finish; 
		//#62500000 $finish; 
		//#6250000 mod_delay_umin <= 16'b1011111100000000;
		//#5787630 mod_delay_umin <= 16'b1011111100000000;
		#5000000 $finish; 
	end 

	always @(posedge clk) begin
		if (s1_high && s1_low ||
			s2_high && s2_low ||
			s3_high && s3_low) short_error <= 1;
		else short_error <= 0;
	end

	always #1 clk <= !clk; // for testing with python (Memory issues)
	//always #5 clk <= !clk; // for accurate timing testing (actual frequency)

	AC_MOTOR_CONTROL control(clk, power, mod_delay_umin, 
		modulation, delay, frequency, u_str);

	AC_MOTOR_SINE_SECTOR sine_sector(clk, frequency, 
		sector_unsynced, sine_pos, sine_neg);

	AC_MOTOR_VECTOR_TIME vector_time(clk, u_str, sine_pos, sine_neg, 
		t0, t1, t2, t7);

	AC_MOTOR_VECTOR_CONTROL vector_control(clk, sector_unsynced, t0, t1, t2, t7, 
		sector_synced, u0, u1, u2, u7);

	AC_MOTOR_SWITCH_CONTROL switch_control(clk, sector_synced, u0, u1, u2, u7, 
		s1, s2, s3);

	AC_MOTOR_SWITCH_DELAY switch_delay_1(clk, enable, delay, s1, 
		s1_high, s1_low);
	AC_MOTOR_SWITCH_DELAY switch_delay_2(clk, enable, delay, s2, 
		s2_high, s2_low);
	AC_MOTOR_SWITCH_DELAY switch_delay_3(clk, enable, delay, s3, 
		s3_high, s3_low);
endmodule

