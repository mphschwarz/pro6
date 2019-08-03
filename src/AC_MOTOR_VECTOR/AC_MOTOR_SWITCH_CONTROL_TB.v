`include "AC_MOTOR_SINE_SECTOR.v"
`include "AC_MOTOR_VECTOR_TIME.v"
`include "AC_MOTOR_VECTOR_CONTROL.v"
`include "AC_MOTOR_SWITCH_CONTROL.v"
`timescale 10ns/1ns // for testing with python (Memory issues)
//`timescale 1ns/100ps // for accurate timing testing (actual frequency)


module AC_MOTOR_SWITCH_CONTROL_TB;
	integer file;
	reg clk;
	reg [11:0] frequency;
	reg [11:0] u_str;
	wire [2:0] sector_unsynced;
	wire [2:0] sector_synced;
	wire [12-1:0] sine_pos;
	wire [12-1:0] sine_neg;
	wire [14:0] t_0;
	wire [14:0] t_1;
	wire [14:0] t_2;
	wire [14:0] t_7;
	wire u_0;
	wire u_1;
	wire u_2;
	wire u_7;
	wire s1;
	wire s2;
	wire s3;

	reg s1_temp;
	reg s2_temp;
	reg s3_temp;
	reg error;

	reg [3:0] u_active;
	reg [3:0] i_active;
	reg [3:0] last_i_active;

	initial begin
		$dumpfile("vcd/ac_motor_switch_control_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_SWITCH_CONTROL_TB); 

		clk <= 1;
		//frequency <= 2**12-1;
		frequency <= 0;
		u_str <= 2**12 - 1;
		#5000000 $finish; 
	end 

	always #1 clk <= !clk; // for testing with python (Memory issues)
	//always #5 clk <= !clk; // for accurate timing testing (actual frequency)
	
	always @(posedge clk) last_i_active <= i_active;

	always @(posedge clk) begin
		if ((last_i_active == 0 && (i_active == 0 || i_active == 1 || i_active == 3 || i_active == 5)) ||
		    (last_i_active == 1 && (i_active == 1 || i_active == 0 || i_active == 2 || i_active == 6)) ||
		    (last_i_active == 2 && (i_active == 2 || i_active == 7 || i_active == 1 || i_active == 3)) ||
		    (last_i_active == 3 && (i_active == 3 || i_active == 0 || i_active == 2 || i_active == 4)) ||
		    (last_i_active == 4 && (i_active == 4 || i_active == 7 || i_active == 3 || i_active == 5)) ||
		    (last_i_active == 5 && (i_active == 5 || i_active == 0 || i_active == 4 || i_active == 6)) ||
		    (last_i_active == 6 && (i_active == 6 || i_active == 7 || i_active == 1 || i_active == 5)) ||
		    (last_i_active == 7 && (i_active == 7 || i_active == 2 || i_active == 4 || i_active == 6))) begin
			error <= 0;
		end else begin
			error <= 1;
		end
	end

	always @(posedge clk) begin
		if (u_0 == 1) u_active <= 0;
		if (u_1 == 1) u_active <= 1;
		if (u_2 == 1) u_active <= 2;
		if (u_7 == 1) u_active <= 3;
	end

	always @(posedge clk) begin
		if (s1 == 0 && s2 == 0 && s3 == 0) i_active <= 0;
		if (s1 == 1 && s2 == 0 && s3 == 0) i_active <= 1;
		if (s1 == 1 && s2 == 1 && s3 == 0) i_active <= 2;
		if (s1 == 0 && s2 == 1 && s3 == 0) i_active <= 3;
		if (s1 == 0 && s2 == 1 && s3 == 1) i_active <= 4;
		if (s1 == 0 && s2 == 0 && s3 == 1) i_active <= 5;
		if (s1 == 1 && s2 == 0 && s3 == 1) i_active <= 6;
		if (s1 == 1 && s2 == 1 && s3 == 1) i_active <= 7;
	end

	AC_MOTOR_SINE_SECTOR sine_sector(
		clk,
		frequency,
		sector_unsynced,
		sine_pos,
		sine_neg
	);

	AC_MOTOR_VECTOR_TIME vector_time(
		clk,
		u_str,
		sine_pos,
		sine_neg,
		t_0,
		t_1,
		t_2,
		t_7
	);

	AC_MOTOR_VECTOR_CONTROL vector_control(
		clk,
		sector_unsynced,
		t_0,
		t_1,
		t_2,
		t_7,
		sector_synced,
		u_0,
		u_1,
		u_2,
		u_7
	);

	AC_MOTOR_SWITCH_CONTROL switch_control(
		clk,
		sector_synced,
		u_0,
		u_1,
		u_2,
		u_7,
		s1,
		s2,
		s3
	);

endmodule

