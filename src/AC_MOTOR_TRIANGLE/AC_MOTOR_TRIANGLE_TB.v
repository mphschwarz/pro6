`include "AC_MOTOR_TRIANGLE.v"
`timescale 10ns/1ns

module AC_MOTOR_TRIANGLE_TB;
	integer file;
	reg clk;
	wire signed [12+12-1:0] triangle;
	wire lock;
	
	initial begin
		clk <= 1;
		$dumpfile("vcd/ac_motor_triangle_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_TRIANGLE_TB); 
		#25000 $finish; 
	end 
	
	always #1 clk <= !clk;
	
	AC_MOTOR_TRIANGLE ac_motor(
		clk,
		lock,
		triangle);
	
endmodule


/*
cd D:\Dropbox\ABBTS_LABOR_DOZ\MOTION_CONTROL\FPGA\FPGA_MODUL_MAX1000_00_21\src\DC_MOTOR
C:\iverilog\bin\iverilog -s ICARUS_TB -o icarus_tb.o ICARUS_TB.v
C:\iverilog\bin\vvp icarus_tb.o

oder 

cd D:\Dropbox\ABBTS_LABOR_DOZ\MOTION_CONTROL\FPGA\FPGA_MODUL_MAX1000_SA_01_00\src\DC_MOTOR
D:\Dropbox\ABBTS_LABOR_DOZ\MOTION_CONTROL\FPGA\FPGA_MODUL_MAX1000_SA_01_00\icarus\iverilog\bin\iverilog -s ICARUS_TB -o icarus_tb.o ICARUS_TB.v
D:\Dropbox\ABBTS_LABOR_DOZ\MOTION_CONTROL\FPGA\FPGA_MODUL_MAX1000_SA_01_00\icarus\iverilog\bin\vvp icarus_tb.o
*/
