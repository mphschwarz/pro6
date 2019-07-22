#!/bin/python
import numpy as np
import matplotlib.pyplot as plt

bits = 12
samples = np.power(2,9)
variable_name = 'sine'

sine = np.sin(np.linspace(0, np.pi / 3, 2 * samples + 1)) * (np.power(2, bits) - 1) / np.sin(np.pi / 3)
sine = [int(x) for x in sine]
sine = sine[1:-1][0::2]
index = np.linspace(0, samples - 1, samples)

plt.plot(index, sine)
plt.show()
print([int(x) for x in sine])

bin_sine = []
for i in range(0, int(len(sine) / 2)):
    bin_sine.append('\t{0}[{1}] = {2}\'b{3:0>12b}; {4}[{5}] = {6}\'b{7:0>12b};\n'
            .format(variable_name, i * 2, bits, int(sine[i * 2]), variable_name, i * 2 + 1, bits, int(sine[i * 2 + 1])))
print(''.join(bin_sine))
