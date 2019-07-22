`include "AC_MOTOR_SINE_SECTOR.v"
`include "AC_MOTOR_VECTOR_TIME.v"
`include "AC_MOTOR_VECTOR_CONTROL.v"
`timescale 10ns/1ns


module AC_MOTOR_VECTOR_CONTROL_TB;
	integer file;
	reg clk;
	reg [11:0] frequency;
	reg [11:0] u_str;
	wire [2:0] sector;
	wire [12-1:0] sine_pos;
	wire [12-1:0] sine_neg;
	wire [14:0] t1;
	wire [14:0] t2;
	wire [14:0] t3;
	wire u0;
	wire u1;
	wire u2;

	initial begin
		$dumpfile("vcd/ac_motor_vector_control_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_VECTOR_CONTROL_TB); 

		clk <= 1;
		//frequency <= 2**12-1;
		frequency <= 0;
		u_str <= 2**12 - 1;
		#250000 $finish; 
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
		t1,
		t2
	);

	AC_MOTOR_VECTOR_CONTROL vector_control(
		clk,
		t1,
		t2,
		u0,
		u1,
		u2
	);
		

endmodule

