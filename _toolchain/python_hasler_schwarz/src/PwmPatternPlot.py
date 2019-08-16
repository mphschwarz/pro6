import Verilog_VCD.Verilog_VCD as Verilog_VCD
import matplotlib.pyplot as plt
import scipy.signal as sig
import numpy as np

import src


file_prefix = '../../src'


def pwm_pattern(phase):
    f_cutoff = 2500
    if phase == 1:
        sigs = ['AC_MOTOR_SWITCH_CONTROL_TB.s1']
        name = '/'
    if phase == 2:
        sigs = ['AC_MOTOR_SWITCH_CONTROL_TB.s2']
        name = '.'
    if phase == 3:
        sigs = ['AC_MOTOR_SWITCH_CONTROL_TB.s3']
        name = '-'
    data = Verilog_VCD.parse_vcd("{}/AC_MOTOR_VECTOR/vcd/ac_motor_switch_control_tb.vcd".format(file_prefix),
                                 siglist=sigs)
    s_time, s_values = src.insert_values(np.array([x[0] for x in data[name]['tv']]),
                                     np.array([x[1] for x in data[name]['tv']]))

    s_values_filtered = src.filter_values(s_values, f_cutoff)

    fig_2, ax1 = plt.subplots(figsize=(10, 5))

    plt.title('PWM-Muster der Phase {}, gefiltert mit Grenzfrequenz {} Hz'.format(phase, f_cutoff))

    ax1.plot(s_time, s_values, color='blue', linewidth=0.2)
    ax1.set_xlabel('Zeit [s]')

    ax2 = ax1.twinx()

    ax2.plot(s_time, s_values_filtered, color='red',linewidth=0.2)

    fig_2.tight_layout()
    #plt.show()
    fig_2.savefig('{}/AC_MOTOR_VECTOR/vcd/ac_motor_switch_control_tb_phase_{}.png'.format(file_prefix, phase))
    del fig_2, ax1, ax2


def pwm_pattern_current(phase):
    """calculates current for space vector modulation without switch delays
    :param phase: either 1, 2 or 3
    :return: nothing"""
    if phase == 1:
        sigs = ['AC_MOTOR_SWITCH_CONTROL_TB.s1']
        name = '/'
    if phase == 2:
        sigs = ['AC_MOTOR_SWITCH_CONTROL_TB.s2']
        name = '.'
    if phase == 3:
        sigs = ['AC_MOTOR_SWITCH_CONTROL_TB.s3']
        name = '-'
    data = Verilog_VCD.parse_vcd("{}/AC_MOTOR_VECTOR/vcd/ac_motor_switch_control_tb.vcd".format(file_prefix),
                                 siglist=sigs)
    s_time, s_values = src.insert_values(np.array([x[0] for x in data[name]['tv']]),
                                         np.array([x[1] for x in data[name]['tv']]))
    s_values *= 330

    s_current = src.current(s_values)

    fig_2, ax1 = plt.subplots(figsize=(10, 5))

    plt.title('Berechneter Spannungs- und Stromverlauf\n'
              'Drehzeigermodulation ohne Totzeiten, 60Hz und volle Amplitude, Phase {}'.format(phase))

    ax1.plot(s_time, s_values, color='blue', linewidth=0.2)
    ax1.set_xlabel('Zeit [s]')
    ax1.set_ylabel('Spannung [V]')

    ax2 = ax1.twinx()

    ax2.plot(s_time, s_current, color='red', linewidth=0.2)

    ax2.set_ylabel('Strom [A]')

    fig_2.tight_layout()
    #plt.show()
    fig_2.savefig('{}/AC_MOTOR_VECTOR/vcd/ac_motor_switch_control_tb_phase_{}_current.png'.format(file_prefix, phase))
    del fig_2, ax1, ax2


if __name__ == '__main__':
    pwm_pattern(1)
    pwm_pattern(2)
    pwm_pattern(3)
    pwm_pattern_current(1)
    pwm_pattern_current(2)
    pwm_pattern_current(3)
