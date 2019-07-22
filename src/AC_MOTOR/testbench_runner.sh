#!/bin/bash
iverilog -s AC_MOTOR_CONTROL_TB -o vcd/icarus_tb.o AC_MOTOR_CONTROL_TB.v
vvp vcd/icarus_tb.o
iverilog -s AC_MOTOR_SWITCH_DELAY_TB -o vcd/icarus_tb.o AC_MOTOR_SWITCH_DELAY_TB.v
vvp vcd/icarus_tb.o
