#!/bin/bash
iverilog -s AC_MOTOR_TRIANGLE_TB -o vcd/icarus_tb.o AC_MOTOR_TRIANGLE_TB.v
vvp vcd/icarus_tb.o
iverilog -s AC_MOTOR_SINE_TB -o vcd/icarus_tb.o AC_MOTOR_SINE_TB.v
vvp vcd/icarus_tb.o
iverilog -s AC_MOTOR_COMPARATOR_TB -o vcd/icarus_tb.o AC_MOTOR_COMPARATOR_TB.v
vvp vcd/icarus_tb.o
