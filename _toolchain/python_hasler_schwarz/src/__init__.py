import Verilog_VCD.Verilog_VCD as Verilog_VCD
import matplotlib.pyplot as plt
import scipy.signal as sig
import numpy as np


def extract_high_low(data, name_high, name_low):
    """extracts high/low three-phase inverter signal
    :param data: signals extracted from .vcd
    :param name_high: name given to net corresponding to s_n_high
    :param name_low: name given to net corresponding to s_n_low
    :return: time_low, values_low, time_high, values_high, all in np.arrays
    """
    signal_length = np.maximum(data[name_high]['tv'][-1][0], data[name_low]['tv'][-1][0])
    s_time_high, s_values_high = insert_values(np.array([x[0] for x in data[name_high]['tv']]),
                                               np.array([x[1] for x in data[name_high]['tv']]), signal_length)
    s_time_low, s_values_low = insert_values(np.array([x[0] for x in data[name_low]['tv']]),
                                             np.array([x[1] for x in data[name_low]['tv']]), signal_length)
    return s_time_low, s_values_low, s_time_high, s_values_high


def insert_voltage(signal_high, signal_low, u_max=330):
    """inserts missing values for each clock cycle for single PWM signal
    :param signal_high: digital signal in np.array, values are only recorded when digital value changes
    :param signal_low: digital signal in np.array, values are only recorded when digital value changes
    :param u_max: DC voltage supplied to three-phase inverter
    :return: voltage in np.array
    """
    voltage = np.zeros(min(len(signal_high), len(signal_low)))
    for index in range(0, min(len(signal_high), len(signal_low))):
        if signal_high[index] > 0 and signal_low[index] < 0:
            voltage[index] = u_max
        elif signal_high[index] < 0 and signal_low[index] > 0:
            voltage[index] = -u_max
        else:
            voltage[index] = 0
    return voltage


def current(voltage, u_rms=480, i_rms=0.3, cos_phi=0.71, f_sample=2 * 100 * np.power(10, 6)):
    """calculates currents for given PWM voltage
    :param voltage:
    :param u_rms:
    :param i_rms:
    :param cos_phi:
    :param f_sample:
    :return:
    """
    r = u_rms / i_rms
    l = cos_phi * r / (2 * np.pi * 60)
    b = [1 / (r + 2 * f_sample * l), 1 / (r + 2 * f_sample * l)]
    a = [1, (r - 2 * f_sample * l) / (r + 2 * f_sample * l)]
    return sig.lfilter(b, a, voltage)[0:len(voltage)]


def filter_values(signal, f_cutoff, order=2, f_sample=2 * 100 * np.power(10, 6)):
    """uses butterworth filter with a cutoff frequency to visualise a PWM pattern
    :param signal: PWM value imported from .vcd file
    :param f_cutoff: cutoff frequency adjusted for sampling frequency
    :param order: order of butterworth filter
    :param f_sample: Motorclock
    :return: filtered PWM signal in np.array
    """
    b, a = sig.butter(order, f_cutoff / (f_sample / 2), btype='low', analog=False)
    return sig.lfilter(b, a, signal)[0:len(signal)]


def insert_values(signal_time_raw, signal_values_raw, signal_length=None):
    """inserts missing values into vector imported from .vcd file
    .vcd only has datapoint when value changes and this function inserts missing values
    so that it can be filtered by an FIR filter"""
    if signal_length is None:
        signal_length = signal_time_raw[-1]
    signal_time = np.linspace(0, signal_length - 1, signal_length)
    signal_values = np.zeros(signal_length)

    for index in range(0, len(signal_time_raw) - 1):
        if signal_values_raw[index] == '1':
            signal_values[signal_time_raw[index]:signal_time_raw[index + 1]] = 1
        else:
            signal_values[signal_time_raw[index]:signal_time_raw[index + 1]] = -1

    return signal_time / (2 * 100 * np.power(10, 6)), signal_values


def plot_vector(v_1, v_2, angles_negative, angles_positive, sample_index):
    """plots diagram to visualise first sector of space vector modulation"""
    v_result = v_1 + v_2
    plt.arrow(0, 0, v_1[0, sample_index], v_1[1, sample_index],
              length_includes_head=True, head_width=0.02, color='red')
    plt.arrow(v_1[0, sample_index], v_1[1, sample_index], v_2[0, sample_index], v_2[1, sample_index],
              length_includes_head=True, head_width=0.02, color='green')
    plt.arrow(0, 0, v_result[0, sample_index], v_result[1, sample_index],
              length_includes_head=True, head_width=0.02, color='blue')

    l_zero = 1 - np.sin(angles_negative[sample_index]) - np.sin(angles_positive[sample_index])
    if l_zero > 0.001:
        result_direction = v_result[:, sample_index] / np.linalg.norm(v_result[:, sample_index])
        plt.arrow(v_result[0, sample_index] + result_direction[0] * l_zero,
                  v_result[1, sample_index] + result_direction[1] * l_zero,
                  -result_direction[0] * l_zero, -result_direction[1] * l_zero,
                  length_includes_head=True, head_width=0.02, color='black')


def plot_current(time, voltage, current, title, file_name):
    """plots PWM voltage and corresponding current with two y scales
    :param time: time vector in np.array
    :param voltage: voltage vector in np.array
    :param current: current vector in np.array
    :param title: title string
    :param file_name: relative path to where plot is saved
    :return:"""
    fig_1, ax1 = plt.subplots(figsize=(10, 5))

    plt.title(title)

    ax1.plot(time, voltage, color='blue', linewidth=0.2)
    ax1.set_xlabel('Zeit [s]')
    ax1.set_ylabel('Spannung [V]', color='blue')
    ax1.set_ylim([-1.1 * np.maximum(np.max(voltage), -np.min(voltage)),
                  1.1 * np.maximum(np.max(voltage), -np.min(voltage))])

    ax2 = ax1.twinx()

    ax2.plot(time, current, color='red', linewidth=0.2)
    ax2.set_ylabel('Strom [A]', color='red')
    ax2.set_ylim([-1.1 * np.maximum(np.max(current), -np.min(current)),
                  1.1 * np.maximum(np.max(current), -np.min(current))])

    plt.tight_layout()
    # plt.show()
    fig_1.savefig(file_name)
    del fig_1, ax1, ax2
