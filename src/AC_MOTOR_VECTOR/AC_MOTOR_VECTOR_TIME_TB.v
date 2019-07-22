`include "AC_MOTOR_SINE_SECTOR.v"
`include "AC_MOTOR_SWITCH_TIME.v"
`timescale 10ns/1ns


module AC_MOTOR_SWITCH_TIME_TB;
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

	initial begin
		$dumpfile("vcd/ac_motor_switch_time_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_SWITCH_TIME_TB); 

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

	AC_MOTOR_SWITCH_TIME switch_time(
		clk,
		u_str,
		sine_pos,
		sine_neg,
		t1,
		t2
	);
		

endmodule
//

/*
cd D:\Dropbox\ABBTS_LABOR_DOZ\MOTION_CONTROL\FPGA\FPGA_MODUL_MAX1000_00_21\src\DC_MOTOR
C:\iverilog\bin\iverilog -s ICARUS_TB -o icarus_tb.o ICARUS_TB.v
C:\iverilog\bin\vvp icarus_tb.o

oder 

cd D:\Dropbox\ABBTS_LABOR_DOZ\MOTION_CONTROL\FPGA\FPGA_MODUL_MAX1000_SA_01_00\src\DC_MOTOR
D:\Dropbox\ABBTS_LABOR_DOZ\MOTION_CONTROL\FPGA\FPGA_MODUL_MAX1000_SA_01_00\icarus\iverilog\bin\iverilog -s ICARUS_TB -o icarus_tb.o ICARUS_TB.v
D:\Dropbox\ABBTS_LABOR_DOZ\MOTION_CONTROL\FPGA\FPGA_MODUL_MAX1000_SA_01_00\icarus\iverilog\bin\vvp icarus_tb.o
*/
