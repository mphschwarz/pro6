`include "DAC_AD5061.v"
// http://verilogtutorial.blogspot.ch/2012/09/verilog-timescale-system-tasks.html
`timescale 10ns/1ns
//
module ICARUS_TB;
	//
	integer file;
	reg clk;
	reg latch;
	reg [15:0] value;
	wire sync_dac;
	wire clk_dac;
	wire sdo_dac;
	//
	initial 
	begin
		clk <= 1;
		latch <= 0;
		value <= 16'h4321;
		//
		$dumpfile("vcd\\\icarus_tb.vcd"); 
		$dumpvars(0, ICARUS_TB); 
		//
		#20 latch <= 1;
		#20 latch <= 0;
		//
		#500 $finish; 
	end 
	//
	always #1 clk <= !clk;
	//
	DAC_AD5061 dac_ad5061(
					clk,
	                latch,
					value,
			        sync_dac,
			        clk_dac,
			        sdo_dac
					);		
	//
endmodule
//
/*
cd D:\Dropbox\ABBTS_DA\FPGA\FPGA_DA_MODUL_MAX1000_00_02\src\ADC_DAC\DAC_AD5061
C:\iverilog\bin\iverilog -s ICARUS_TB -o icarus_tb.o ICARUS_TB.v
C:\iverilog\bin\vvp icarus_tb.o
*/