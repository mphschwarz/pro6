`include "AC_MOTOR_SINE_SECTOR.v"
`include "AC_MOTOR_VECTOR_TIME.v"
`timescale 1ns/100ps


module AC_MOTOR_VECTOR_TIME_TB;
	integer file;
	reg clk;
	reg [11:0] frequency;
	reg [11:0] u_str;
	wire [2:0] sector;
	wire [12-1:0] sine_pos;
	wire [12-1:0] sine_neg;
	wire [14:0] t0;
	wire [14:0] t1;
	wire [14:0] t2;
	wire [14:0] t7;

	reg error;

	initial begin
		$dumpfile("vcd/ac_motor_vector_time_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_VECTOR_TIME_TB); 

		clk <= 1;
		//frequency <= 2**12-1;
		frequency <= 0;
		u_str <= 2**12 - 1;
		#25000000 $finish; 
	end 

	always @(posedge clk) begin
		if ((t0 + t1 + t2 + t7 == 2 + 100*10**6 / (5*10**3) || t0 + t1 + t2 + t7 == 100*10**6 / (5*10**3) - 2)) error <= 1;
		else error <= 0;
	end
	always #5 clk <= !clk;

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
		t0,
		t1,
		t2,
		t7
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
