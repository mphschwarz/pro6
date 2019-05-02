`include "ADC_LTC2313_12.v"
// http://verilogtutorial.blogspot.ch/2012/09/verilog-timescale-system-tasks.html
`timescale 1ns/1ns
//
module ICARUS_TB;
	//
	integer file;
	reg clk;
	reg latch;
	reg sdi_adc;
	wire conv_adc;
	wire clk_adc;
	wire [15:0] value;
	//
	wire conv_adc_avg;
	wire clk_adc_avg;
	wire [15:0] value_avg;	
	wire [15:0] value_mov_avg;
	wire latch_dac;
	//
	initial 
	begin
		clk <= 1;
		latch <= 0;
		sdi_adc <= 0;
		//
		$dumpfile("vcd\\\icarus_tb.vcd"); 
		$dumpvars(0, ICARUS_TB); 
		//
		#50 latch <= 1;
		#50  latch <= 0;
		//
		#190  sdi_adc <= 0;// NULL BIT
		//
		#80  sdi_adc <= 1;// B11
		#80  sdi_adc <= 0;// B10
		#80  sdi_adc <= 0;// B9
		#80  sdi_adc <= 0;// B8
		#80  sdi_adc <= 0;// B7
		#80  sdi_adc <= 0;// B6
		#80  sdi_adc <= 0;// B5
		#80  sdi_adc <= 0;// B4
		#80  sdi_adc <= 0;// B3
		#80  sdi_adc <= 0;// B2
		#80  sdi_adc <= 0;// B1
		#80  sdi_adc <= 0;// B0
		#80  sdi_adc <= 0;// HI-Z
		//
		#2000 latch <= 1;
		#50  latch <= 0;
		//
		#2000 latch <= 1;
		#50  latch <= 0;
		//
		#2000 latch <= 1;
		#50  latch <= 0;
		//
		#2000 latch <= 1;
		#50  latch <= 0;
		//
		#2000 latch <= 1;
		#50  latch <= 0;
		//
		#2000 $finish; 
	end 
	//
	always #5 clk <= !clk;// 100 MHz
	//
	ADC_LTC2313_12 adc_ltc2313_12(
					clk,
	                latch,
			        sdi_adc,
			        conv_adc,
			        clk_adc,
			        value
					);
	//
	ADC_LTC2313_12_MOV_AVG adc_ltc2313_mov_avg(
					clk,
	                latch,
			        sdi_adc,
			        conv_adc_avg,
			        clk_adc_avg,
			        value_avg,
					value_mov_avg,
					latch_dac
					);
	//
	
endmodule
//
/*
cd D:\Dropbox\ABBTS_DA\FPGA\FPGA_DA_MODUL_MAX1000_00_02\src\ADC_DAC\ADC_LTC2313_12
C:\iverilog\bin\iverilog -s ICARUS_TB -o icarus_tb.o ICARUS_TB.v
C:\iverilog\bin\vvp icarus_tb.o
*/
