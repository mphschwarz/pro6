`include "AC_MOTOR_SINE.v"
`timescale 10ns/1ns


module AC_MOTOR_SINE_TB;
	integer file;
	reg clk;
	reg lock;
	reg cw;
	reg ccw;
	reg [11:0] frequency;
	reg signed [11:0] amplitude;
	//
	wire signed [24-1:0] sine1;
	wire signed [24-1:0] sine2;
	wire signed [24-1:0] sine3;
	//
	initial begin
		$dumpfile("vcd/ac_motor_sine_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_SINE_TB); 

		clk <= 1;
		cw <= 0;
		ccw <= 1;
		frequency <= 2**12;
		amplitude <= 2**11;
		lock <= 0;
		#1 lock <= 0;
		#2 lock <= 1;
		#3 lock <= 0;

		#250000 $finish; 
	end 
	//

	always #1 clk <= !clk;

	AC_MOTOR_SINE sine(
		clk,
		frequency,
		amplitude,
		cw,
		ccw,
		lock,
		sine1,
		sine2,
		sine3);
	//
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
