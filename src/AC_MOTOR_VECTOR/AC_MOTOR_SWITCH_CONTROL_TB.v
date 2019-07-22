`include "AC_MOTOR_SINE_SECTOR.v"
`include "AC_MOTOR_VECTOR_TIME.v"
`include "AC_MOTOR_VECTOR_CONTROL.v"
`include "AC_MOTOR_SWITCH_CONTROL.v"
`timescale 10ns/1ns


module AC_MOTOR_SWITCH_CONTROL_TB;
	integer file;
	reg clk;
	reg [11:0] frequency;
	reg [11:0] u_str;
	wire [2:0] sector;
	wire [12-1:0] sine_pos;
	wire [12-1:0] sine_neg;
	wire [14:0] t_low;
	wire [14:0] t_high;
	wire u_0;
	wire u_low;
	wire u_high;
	wire s1;
	wire s2;
	wire s3;

	initial begin
		$dumpfile("vcd/ac_motor_switch_control_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_SWITCH_CONTROL_TB); 

		clk <= 1;
		//frequency <= 2**12-1;
		frequency <= 0;
		u_str <= 2**12 - 1;
		#5000000 $finish; 
	end 

	always #1 clk <= !clk;

	AC_MOTOR_SINE_SECTOR sine_sector(
		clk,
		frequency,
		sector,
		sine_pos,
		sine_neg
	);

	AC_MOTOR_VECTOR_TIME vector_time(
		clk,
		u_str,
		sine_pos,
		sine_neg,
		t_low,
		t_high
	);

	AC_MOTOR_VECTOR_CONTROL vector_control(
		clk,
		t_low,
		t_high,
		u_0,
		u_low,
		u_high
	);

	AC_MOTOR_SWITCH_CONTROL switch_control(
		clk,
		sector,
		u_0,
		u_low,
		u_high,
		s1,
		s2,
		s3
	);

endmodule

