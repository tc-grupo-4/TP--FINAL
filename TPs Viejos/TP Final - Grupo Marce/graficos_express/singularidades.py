from transfer2 import H
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import patches
from matplotlib.pyplot import axvline, axhline
from collections import defaultdict
from audiolazy import *
from scipy import signal
from numpy import pi
import matplotlib.patches as mpatches
from matplotlib.patches import Patch

from matplotlib.lines import Line2D

ss = signal.ZerosPolesGain(H[5])

z, p, k = ss.zeros, ss.poles, ss.gain

z = [i/1000.0/2/pi for i in z]
p = [i/1000.0/2/pi for i in p]

plt.plot([], [], 'or')
plt.plot([], [], 'xb')
plt.legend(['Ceros', 'Polos'], loc=2)

for pole in p:
    if np.imag(pole) > 0:
        plt.plot([np.real(pole), 0], [np.imag(pole), 0],color='skyblue')
        data = int(abs(pole)*100)/100
        q = - abs(pole) / (2*np.real(pole))
        data_q = int(abs(q)*100)/100
        if data == 13.85 or data == 25.95:
            corr_y = -3.3
            corr_x = -4.8
        else:
            corr_y = 0
            corr_x = 0
        plt.text(0.5 + np.real(pole)+corr_x, 1.7 + np.imag(pole) + corr_y, "$f_0="+str(data)+"$",fontsize=8)
        plt.text(0.5 + np.real(pole)+corr_x, 0.5 + np.imag(pole) +corr_y, "$Q=" + str(data_q)+"$" ,fontsize=8)

    else:
        plt.plot([np.real(pole), 0], [np.imag(pole), 0], color='skyblue')

plt.plot(np.real(z), np.imag(z), 'or')
plt.plot(np.real(p), np.imag(p), 'xb')
plt.legend(['Zeros', 'Poles'], loc=2)



plt.minorticks_on()
plt.grid(which='major', linestyle='-', linewidth=0.3, color='black')
plt.grid(which='minor', linestyle=':', linewidth=0.1, color='black')

plt.text(0.3, 0.2, "12")

plt.xlabel("$\sigma$ (KHz)")

plt.ylabel("jw (KHz)")


#plt.show()
plt.savefig("output/singularidades.png")