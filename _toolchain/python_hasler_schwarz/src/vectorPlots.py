import matplotlib.pyplot as plt
import numpy as np

import src


def plot_sector():
    samples = 51
    angles_positive = np.linspace(0, np.pi / 3, samples)
    angles_negative = np.linspace(np.pi / 3, 0, samples)
    v_1 = np.array([np.sin(angles_negative), np.zeros(samples)])
    v_2 = np.array([np.cos(np.pi / 3) * np.sin(angles_positive), np.sin(np.pi / 3) * np.sin(angles_positive)])

    v_result = v_1 + v_2

    plt.plot(v_result[0], v_result[1], color='blue')
    plt.arrow(0, 0, 1, 0, length_includes_head=True, head_width=0.02, color='red')
    plt.arrow(0, 0, np.cos(np.pi / 3), np.sin(np.pi / 3), length_includes_head=True, head_width=0.02, color='green')
    plt.plot([1, np.cos(np.pi / 3)], [0, np.sin(np.pi / 3)], color='black')

    src.plot_vector(v_1, v_2, angles_negative, angles_positive, 3)
    src.plot_vector(v_1, v_2, angles_negative, angles_positive, 12)
    src.plot_vector(v_1, v_2, angles_negative, angles_positive, 25)
    src.plot_vector(v_1, v_2, angles_negative, angles_positive, 37)

    plt.legend(['resultierender Vektor', 'U_1', 'U_2', 'Nullvektor'])

    plt.xlim(-0.1, 1.1)
    plt.ylim(-0.1, 0.9)
    plt.gca().set_aspect('equal', adjustable='box')
    plt.tight_layout()
    plt.savefig('data/vector_visualisation.png')


if __name__ == '__main__':
    plot_sector()
