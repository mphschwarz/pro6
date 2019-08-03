`include "AC_MOTOR_SWITCH_DELAY.v"
`timescale 1ns/100ps

module AC_MOTOR_SWITCH_DELAY_SIMPLE_TB;
integer file;
reg clk;
reg enable;
reg [10:0] delay;
reg s_in;
wire s_high;
wire s_low;

initial begin
	$dumpfile("vcd/ac_motor_switch_delay_simple_tb.vcd"); 
	$dumpvars(0, AC_MOTOR_SWITCH_DELAY_SIMPLE_TB); 

	clk <= 1;
	s_in <= 0;
	delay <= 15;
	enable <= 1;
	
	#10000 delay <= 10;
	#10000 delay <= 20;
	#10000 $finish; 

end

always #5 clk <= !clk;

always #1000 s_in <= !s_in;

AC_MOTOR_SWITCH_DELAY switch_delay(
	clk,
	enable,
	delay,
	s_in,
	s_high,
	s_low);

endmodule
