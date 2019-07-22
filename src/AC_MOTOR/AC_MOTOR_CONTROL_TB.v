`include "AC_MOTOR_CONTROL.v"
`timescale 10ns/1ns


module AC_MOTOR_CONTROL_TB;
	integer file;
	reg clk;
	reg [11:0] power;
	reg [15:0] mod_delay_umin;
	wire modulation;
	wire [10:0] delay;
	wire [11:0] frequency;
	wire [11:0] amplitude;
	wire [11:0] u_str;
	
	initial begin
		$dumpfile("vcd/ac_motor_control_tb.vcd"); 
		$dumpvars(0, AC_MOTOR_CONTROL_TB); 

		clk <= 1;
		
		mod_delay_umin <=     16'b0111111100000000;
		power <= 0;
		#10 power <= 2**12 - 1;
		#15 mod_delay_umin <= 16'b1111111100000000;
		#20 power <= 2**11 - 1;
		#25 mod_delay_umin <= 16'b1000000011111110;

		#25000 $finish; 
	end 

	always #1 clk <= !clk;

	AC_MOTOR_CONTROL control(
		clk,
		power,
		mod_delay_umin,
		modulation,
		delay,
		frequency,
		amplitude);

endmodule

