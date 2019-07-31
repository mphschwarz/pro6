#!/bin/bash
# iverilog -s AC_MOTOR_SINE_SECTOR_TB -o vcd/icarus_tb.o AC_MOTOR_SINE_SECTOR_TB.v
# vvp vcd/icarus_tb.o
# iverilog -s AC_MOTOR_VECTOR_TIME_TB -o vcd/icarus_tb.o AC_MOTOR_VECTOR_TIME_TB.v
# vvp vcd/icarus_tb.o
# iverilog -s AC_MOTOR_VECTOR_CONTROL_TB -o vcd/icarus_tb.o AC_MOTOR_VECTOR_CONTROL_TB.v
# vvp vcd/icarus_tb.o
iverilog -s AC_MOTOR_SWITCH_CONTROL_TB -o vcd/icarus_tb.o AC_MOTOR_SWITCH_CONTROL_TB.v
vvp vcd/icarus_tb.o
