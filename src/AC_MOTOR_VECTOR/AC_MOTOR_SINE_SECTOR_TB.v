`include "AC_MOTOR_SINE_SECTOR.v"
`timescale 10ns/1ns


module AC_MOTOR_SINE_SECTOR_TB;
	integer file;
	reg clk;
	reg [11:0] frequency;
	wire [2:0] sector;
	wire [12-1:0] sine_pos;
	wire [12-1:0] sine_neg;

	initial begin
		$dumpfile("vcd/ac_motor_sine_sector_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_SINE_SECTOR_TB); 

		clk <= 1;
		//frequency <= 2**12-1;
		frequency <= 0;
		#250000 $finish; 
	end 

	always #1 clk <= !clk;

	AC_MOTOR_SINE_SECTOR sine(
		clk,
		frequency,
		sector,
		sine_pos,
		sine_neg
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
