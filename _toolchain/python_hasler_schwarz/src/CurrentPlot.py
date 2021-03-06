import Verilog_VCD.Verilog_VCD as Verilog_VCD
import matplotlib.pyplot as plt
import scipy.signal as sig
import numpy as np

import src

file_prefix = '../../src'


def current_plot_vector(phase):
    """plots testbench results with space vector modulation"""
    if phase == 1:
        sigs = ['AC_MOTOR_SWITCH_DELAY_TB.s1_high', 'AC_MOTOR_SWITCH_DELAY_TB.s1_low']
        high = '5'
        low = '4'
    elif phase == 2:
        sigs = ['AC_MOTOR_SWITCH_DELAY_TB.s2_high', 'AC_MOTOR_SWITCH_DELAY_TB.s2_low']
        high = '2'
        low = '1'
    elif phase == 3:
        sigs = ['AC_MOTOR_SWITCH_DELAY_TB.s3_high', 'AC_MOTOR_SWITCH_DELAY_TB.s3_low']
        high = '/'
        low = '.'
    else:
        return

    data = Verilog_VCD.parse_vcd("{}/AC_MOTOR/vcd/ac_motor_switch_delay_tb.vcd".format(file_prefix), siglist=sigs)

    s_time_low, s_values_low, s_time_high, s_values_high = src.extract_high_low(data, high, low)

    s_voltage = src.insert_voltage(s_values_high, s_values_low)
    s_current = src.current(s_voltage)

    src.plot_current(s_time_high, s_voltage, s_current,
                     'Berechneter Spannungs- und Stromverlauf\nDrehzeigermodulation, 60Hz und volle Amplitude, Phase {}'
                     .format(phase),
                     '{}/AC_MOTOR/vcd/ac_motor_switch_delay_tb_phase_{}.png'.format(file_prefix, phase))
    print('plotted vector, phase {}'.format(phase))


def current_plot_triangle(phase):
    """plots testbench results with subharmonic modulation"""
    if phase == 1:
        sigs = ['AC_MOTOR_SWITCH_DELAY_TRIANGLE_TB.s1_high', 'AC_MOTOR_SWITCH_DELAY_TRIANGLE_TB.s1_low']
        high = ','
        low = '+'
    elif phase == 2:
        sigs = ['AC_MOTOR_SWITCH_DELAY_TRIANGLE_TB.s2_high', 'AC_MOTOR_SWITCH_DELAY_TRIANGLE_TB.s2_low']
        high = ')'
        low = '('
    elif phase == 3:
        sigs = ['AC_MOTOR_SWITCH_DELAY_TRIANGLE_TB.s3_high', 'AC_MOTOR_SWITCH_DELAY_TRIANGLE_TB.s3_low']
        high = '&'
        low = '%'
    else:
        return

    data = Verilog_VCD.parse_vcd("{}/AC_MOTOR/vcd/ac_motor_switch_delay_triangle_tb.vcd".format(file_prefix),
                                 siglist=sigs)

    s_time_low, s_values_low, s_time_high, s_values_high = src.extract_high_low(data, high, low)

    s_voltage = src.insert_voltage(s_values_high, s_values_low)
    s_current = src.current(s_voltage)

    src.plot_current(s_time_high, s_voltage, s_current,
                     'Berechneter Spannungs- und Stromverlauf\n'
                     'Unterschwingungsverfahren, 60Hz und volle Amplitude, Phase {}'
                     .format(phase),
                     '{}/AC_MOTOR/vcd/ac_motor_switch_delay_triangle_tb_phase_{}.png'.format(file_prefix, phase))
    print('plotted triangle, phase {}'.format(phase))


def current_plot_modulation_switch(phase):
    """plots testbench results with space vector modulation and subharmonic modulation"""
    if phase == 1:
        sigs = ['AC_MOTOR_SWITCH_DELAY_MODULATION_CHANGE_TB.s1_high',
                'AC_MOTOR_SWITCH_DELAY_MODULATION_CHANGE_TB.s1_low']
        high = 'B'
        low = 'A'
    elif phase == 2:
        sigs = ['AC_MOTOR_SWITCH_DELAY_MODULATION_CHANGE_TB.s2_high',
                'AC_MOTOR_SWITCH_DELAY_MODULATION_CHANGE_TB.s2_low']
        high = '<'
        low = ';'
    elif phase == 3:
        sigs = ['AC_MOTOR_SWITCH_DELAY_MODULATION_CHANGE_TB.s3_high',
                'AC_MOTOR_SWITCH_DELAY_MODULATION_CHANGE_TB.s3_low']
        high = '6'
        low = '5'
    else:
        return

    data = Verilog_VCD.parse_vcd("{}/AC_MOTOR/vcd/ac_motor_switch_delay_modulation_change_tb.vcd".format(file_prefix),
                                 siglist=sigs)

    s_time_low, s_values_low, s_time_high, s_values_high = src.extract_high_low(data, high, low)

    s_voltage = src.insert_voltage(s_values_high, s_values_low)
    s_current = src.current(s_voltage)

    src.plot_current(s_time_high, s_voltage, s_current,
                     'Berechneter Spannungs- und Stromverlauf, 60Hz und volle Amplitude, Phase {}\n'
                     'Modulationsverfahren geändert von Drehzeiger- zu Unterschwingungsveraheren bei t={}s'
                     .format(phase, 2500000 / (2 * 100 * np.power(10, 6))),
                     '{}/AC_MOTOR/vcd/ac_motor_switch_delay_tb_phase_{}_modulation_switch.png'
                     .format(file_prefix, phase))
    print('plotted modulation_change, phase {}'.format(phase))


def current_plot_power_ramp(phase):
    """plots testbench results with varying values for power"""
    if phase == 1:
        sigs = ['AC_MOTOR_SWITCH_DELAY_POWER_CHANGE_TB.s1_high',
                'AC_MOTOR_SWITCH_DELAY_POWER_CHANGE_TB.s1_low']
        high = '5'
        low = '4'
    elif phase == 2:
        sigs = ['AC_MOTOR_SWITCH_DELAY_POWER_CHANGE_TB.s2_high',
                'AC_MOTOR_SWITCH_DELAY_POWER_CHANGE_TB.s2_low']
        high = '2'
        low = '1'
    elif phase == 3:
        sigs = ['AC_MOTOR_SWITCH_DELAY_POWER_CHANGE_TB.s3_high',
                'AC_MOTOR_SWITCH_DELAY_POWER_CHANGE_TB.s3_low']
        high = '/'
        low = '.'
    else:
        return

    data = Verilog_VCD.parse_vcd("{}/AC_MOTOR/vcd/ac_motor_switch_delay_power_change_tb.vcd".format(file_prefix),
                                 siglist=sigs)

    s_time_low, s_values_low, s_time_high, s_values_high = src.extract_high_low(data, high, low)

    s_voltage = src.insert_voltage(s_values_high, s_values_low)
    s_current = src.current(s_voltage)

    src.plot_current(s_time_high, s_voltage, s_current,
                     'Berechneter Spannungs- und Stromverlauf, Phase {}\n'
                     'Drehzal wird von voller zu 0.75 zu 0.5 gewechselt bei t={}s und t={}s'
                     .format(phase, 12500000 / (2 * 100 * np.power(10, 6)), 25000000 / (2 * 100 * np.power(10, 6))),
                     '{}/AC_MOTOR/vcd/ac_motor_switch_delay_tb_phase_{}_power_ramp.png'.format(file_prefix, phase)
                     .format(phase))
    print('plotted power_change, phase {}'.format(phase))


if __name__ == '__main__':
    #current_plot_power_ramp(1)
    #current_plot_power_ramp(2)
    #current_plot_power_ramp(3)

    current_plot_vector(1)
    current_plot_vector(2)
    current_plot_vector(3)

    current_plot_triangle(1)
    current_plot_triangle(2)
    current_plot_triangle(3)

    current_plot_modulation_switch(1)
    current_plot_modulation_switch(2)
    current_plot_modulation_switch(3)
