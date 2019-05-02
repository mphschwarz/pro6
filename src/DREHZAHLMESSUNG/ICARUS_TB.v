`include "DREHZAHLMESSUNG.v"
// http://verilogtutorial.blogspot.ch/2012/09/verilog-timescale-system-tasks.html
`timescale 10ns/1ns
//
module ICARUS_TB;
	integer file;
	reg clk;
	reg in;
	wire [31:0] speed;	
	//
	initial 
		begin
			clk <= 1;
			in <= 0;
			//
			$dumpfile("vcd\\\icarus_tb.vcd"); 
			$dumpvars(0, ICARUS_TB); 
			//
			#2000 in <= 1;
			#2000 in <= 0;
			
			#2000 in <= 1;
			#2000 in <= 0;
			
			#2000 in <= 1;
			#2000 in <= 0;
			
			#2000 in <= 1;
			#2000 in <= 0;
			
			#2000 in <= 1;
			#2000 in <= 0;
			
			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;
			
			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;			

			#2000 in <= 1;
			#2000 in <= 0;	
			
			#2000 in <= 1;
			#2000 in <= 0;	

			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;
			
			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;			

			#2000 in <= 1;
			#2000 in <= 0;	
			
			#2000 in <= 1;
			#2000 in <= 0;	

			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;
			
			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;			

			#2000 in <= 1;
			#2000 in <= 0;	
			
			#2000 in <= 1;
			#2000 in <= 0;	

			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;
			
			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;			

			#2000 in <= 1;
			#2000 in <= 0;	
			
			#2000 in <= 1;
			#2000 in <= 0;	

			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;
			
			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;

			#2000 in <= 1;
			#2000 in <= 0;			

			#2000 in <= 1;
			#2000 in <= 0;	
			
			#2000 in <= 1;
			#2000 in <= 0;	
			
			//
			#2000 $finish; 
		end 
	//
	always #1 clk <= !clk;
	//
	DREHZAHLMESSUNG drehzahlmessung(clk,
									in,
									speed
									);
	//
endmodule
/*
cd D:\Dropbox\ABBTS_DA\FPGA\FPGA_DA_MODUL_MAX1000_00_11_PH\src\DREHZAHLMESSUNG
C:\iverilog\bin\iverilog -s ICARUS_TB -o icarus_tb.o ICARUS_TB.v
C:\iverilog\bin\vvp icarus_tb.o
*/