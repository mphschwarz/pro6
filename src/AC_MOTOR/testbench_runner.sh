#!/bin/bash
iverilog -s AC_MOTOR_SWITCH_DELAY_SIMPLE_TB -o vcd/icarus_tb.o AC_MOTOR_SWITCH_DELAY_SIMPLE_TB.v
# vvp vcd/icarus_tb.o
iverilog -s AC_MOTOR_SWITCH_DELAY_TB -o vcd/icarus_tb.o AC_MOTOR_SWITCH_DELAY_TB.v
# vvp vcd/icarus_tb.o
iverilog -s AC_MOTOR_SWITCH_DELAY_MODULATION_CHANGE_TB -o vcd/icarus_tb.o AC_MOTOR_SWITCH_DELAY_MODULATION_CHANGE_TB.v
# vvp vcd/icarus_tb.o
iverilog -s AC_MOTOR_SWITCH_DELAY_POWER_CHANGE_TB -o vcd/icarus_tb.o AC_MOTOR_SWITCH_DELAY_POWER_CHANGE_TB.v
vvp vcd/icarus_tb.o
iverilog -s AC_MOTOR_SWITCH_DELAY_TRIANGLE_TB -o vcd/icarus_tb.o AC_MOTOR_SWITCH_DELAY_TRIANGLE_TB.v
# vvp vcd/icarus_tb.o
