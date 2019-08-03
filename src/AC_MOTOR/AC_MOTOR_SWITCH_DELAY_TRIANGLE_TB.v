`include "../AC_MOTOR_TRIANGLE/AC_MOTOR_SINE.v"
`include "../AC_MOTOR_TRIANGLE/AC_MOTOR_TRIANGLE.v"
`include "../AC_MOTOR_TRIANGLE/AC_MOTOR_COMPARATOR.v"
`include "AC_MOTOR_SWITCH_DELAY.v"
`include "AC_MOTOR_CONTROL.v"
`timescale 10ns/1ns

module AC_MOTOR_SWITCH_DELAY_TRIANGLE_TB;
	integer file;
	reg clk;
	reg [11:0] power;
	reg [15:0] mod_delay_umin;
	reg enable;
	wire modulation;
	wire lock;
	
	wire [11:0] frequency;
	wire [11:0] amplitude;
	wire [10:0] delay;

	wire [23:0] sine_val_1;
	wire [23:0] sine_val_2;
	wire [23:0] sine_val_3;
	wire [23:0] triangle;
	
	wire s1;
	wire s2;
	wire s3;

	wire s1_high;
	wire s1_low;
	wire s2_high;
	wire s2_low;
	wire s3_high;
	wire s3_low;

	always #1 clk <= !clk;

	initial begin
		$dumpfile("vcd/ac_motor_switch_delay_triangle_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_SWITCH_DELAY_TRIANGLE_TB); 
		clk <= 1;
		power <= 2**12 - 1;
		mod_delay_umin <= 16'b1000000000000000;
		enable <= 1;

		#5000000 $finish; 
	end

	AC_MOTOR_CONTROL control(clk, power, mod_delay_umin,
		                     modulation, delay, frequency, amplitude);

	AC_MOTOR_SINE sine_generator(clk, frequency, amplitude, lock,
			                     sine_val_1, sine_val_2, sine_val_3);
	
	AC_MOTOR_TRIANGLE triangle_generator(clk, lock, triangle);
	
    AC_MOTOR_COMPARATOR comparator_1(clk, triangle, sine_val_1, s1);
    AC_MOTOR_COMPARATOR comparator_2(clk, triangle, sine_val_2, s2);
    AC_MOTOR_COMPARATOR comparator_3(clk, triangle, sine_val_3, s3);
	
	AC_MOTOR_SWITCH_DELAY delay_1(clk, enable, delay, s1, s1_high, s1_low);
	AC_MOTOR_SWITCH_DELAY delay_2(clk, enable, delay, s2, s2_high, s2_low);
	AC_MOTOR_SWITCH_DELAY delay_3(clk, enable, delay, s3, s3_high, s3_low);

endmodule
