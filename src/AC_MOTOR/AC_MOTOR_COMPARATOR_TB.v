`include "AC_MOTOR_SINE.v"
`include "AC_MOTOR_TRIANGLE.v"
`include "AC_MOTOR_COMPARATOR.v"
`timescale 10ns/1ns


module AC_MOTOR_COMPARATOR_TB;
	integer file;
	reg clk;
	reg enable;
	reg [11:0] amplitude;
	reg [11:0] frequency;
	//
	wire signed [23:0] triangle;
	wire signed [23:0] sine1;
	wire signed [23:0] sine2;
	wire signed [23:0] sine3;

	reg cw;
	reg ccw;

	wire lock;

	wire out1;
	wire out2;
	wire en1;
	wire en2;
	//
	initial begin
		clk <= 1;
		enable <= 1;
		frequency <= 2**7 - 1;
		amplitude <= 2**11 - 1;
		cw <= 0;
		ccw <= 1;

		$dumpfile("vcd/ac_motor_comparator_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_COMPARATOR_TB); 
		//#25000 $finish; 
		//#124500 frequency <= 2**12 - 1;
		#250000 $finish;
	end 
	//
	always #1 clk <= !clk;
	
	AC_MOTOR_COMPARATOR comparator1(
		clk,
		enable,
		triangle,
		sine1,
		out1,
		out2,
		en1,
		en2);
	AC_MOTOR_TRIANGLE triangle_gen(
		clk,
		lock,
		triangle);
	AC_MOTOR_SINE sine_gen(
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
