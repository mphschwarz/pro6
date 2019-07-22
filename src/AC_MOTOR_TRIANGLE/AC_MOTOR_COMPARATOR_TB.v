`include "AC_MOTOR_SINE.v"
`include "AC_MOTOR_TRIANGLE.v"
`include "AC_MOTOR_COMPARATOR.v"
`timescale 10ns/1ns


module AC_MOTOR_COMPARATOR_TB;
	integer file;
	reg clk;

	reg modulation;
	reg [10:0] dead_time;
	reg [11:0] amplitude;
	reg [11:0] frequency;
	
	wire signed [23:0] triangle;
	wire signed [23:0] sine1;
	wire signed [23:0] sine2;
	wire signed [23:0] sine3;

	wire lock;

	wire out;
	
	initial begin
		clk <= 1;
		dead_time <= 1000;
		frequency <= 0;
		amplitude <= 2**12 - 1;

		$dumpfile("vcd/ac_motor_comparator_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_COMPARATOR_TB); 
		#500000 $finish;
	end 

	always #1 clk <= !clk;
	
	AC_MOTOR_COMPARATOR comparator1(
		clk,
		triangle,
		sine1,
		out);
	AC_MOTOR_TRIANGLE triangle_gen(
		clk,
		lock,
		triangle);
	AC_MOTOR_SINE sine_gen(
		clk,
		frequency,
		amplitude,
		lock,
		sine1,
		sine2,
		sine3);

endmodule

/*
iverilog -s AC_MOTOR_COMPARATOR_TB -o icarus_tb.o AC_MOTOR_COMPARATOR_TB.v
vvp icarus_tb.o
*/
