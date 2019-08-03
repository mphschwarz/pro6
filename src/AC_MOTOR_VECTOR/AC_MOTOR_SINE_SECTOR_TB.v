`include "AC_MOTOR_SINE_SECTOR.v"
`timescale 1ns/100ps


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
		#25000000 $finish; 
	end 

	always #5 clk <= !clk;

	AC_MOTOR_SINE_SECTOR sine(
		clk,
		frequency,
		sector,
		sine_pos,
		sine_neg
	);

endmodule

