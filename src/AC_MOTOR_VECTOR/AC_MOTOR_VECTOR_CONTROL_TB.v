`include "AC_MOTOR_SINE_SECTOR.v"
`include "AC_MOTOR_VECTOR_TIME.v"
`include "AC_MOTOR_VECTOR_CONTROL.v"
//`timescale 10ns/1ns // for testing with python (Memory issues)
`timescale 1ns/100ps // for accurate timing testing (actual frequency)

module AC_MOTOR_VECTOR_CONTROL_TB;
	integer file;
	reg clk;
	reg [11:0] frequency;
	reg [11:0] u_str;
	wire [2:0] sector_synced;
	wire [2:0] sector_unsynced;
	wire [12-1:0] sine_pos;
	wire [12-1:0] sine_neg;
	wire [14:0] t0;
	wire [14:0] t1;
	wire [14:0] t2;
	wire [14:0] t3;
	wire [14:0] t7;
	wire u0;
	wire u1;
	wire u2;
	wire u7;

	initial begin
		$dumpfile("vcd/ac_motor_vector_control_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_VECTOR_CONTROL_TB); 

		clk <= 1;
		//frequency <= 2**12-1;
		frequency <= 0;
		u_str <= 2**12 - 1;
		#25000000 $finish; 
	end 

	//always #1 clk <= !clk; // for testing with python (Memory issues)
	always #5 clk <= !clk; // for accurate timing testing (actual frequency)

	AC_MOTOR_SINE_SECTOR sine_sector(
		clk,
		frequency,
		sector_unsynced,
		sine_pos,
		sine_neg
	);

	AC_MOTOR_VECTOR_TIME vector_time(
		clk,
		sector_unsynced,
		u_str,
		sine_pos,
		sine_neg,
		t0,
		t1,
		t2,
		t7
	);

	AC_MOTOR_VECTOR_CONTROL vector_control(
		clk,
		sector_unsynced,
		t0,
		t1,
		t2,
		t7,
		sector_synced,
		u0,
		u1,
		u2,
		u7
	);
		

endmodule

