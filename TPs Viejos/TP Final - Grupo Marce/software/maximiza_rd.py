# coding=utf-8
import sympy as sp
from numpy import pi
from utils import etapas, algebra
from utils.computeRD import computeRD, setGain
import itertools
from scipy import signal
from numpy import logspace

s = sp.symbols('s')

Wo1 = 2*pi*12948.60
Q1 = 11.58
Wo2 = 2*pi*13850.42
Q2 = 3.65
Wo3 = 2*pi*15845.49
Q3 = 1.96
Wo4 = 2*pi*19525.55
Q4 = 1.19
Wo5 = 2*pi*25958.29
Q5 = 0.76
Wo6 = 2*pi*34110.10
Q6 = 0.53

H1 = s**2/(s**2 + s*Wo1/Q1 + Wo1**2)
H2 = s**2/(s**2 + s*Wo2/Q2 + Wo2**2)
H3 = s**2/(s**2 + s*Wo3/Q3 + Wo3**2)
H4 = s**2/(s**2 + s*Wo4/Q4+ Wo4**2)
H5 = s**2/(s**2 + s*Wo5/Q5 + Wo5**2)
H6 = s**2/(s**2 + s*Wo6/Q6 + Wo6**2)

conjunto = H1 * H2 * H3 * H4 * H5 * H6

w, mag, pha = signal.bode(algebra.conseguir_tf(conjunto, s), [1e7*2*pi])
total_gain = -mag[0]

#
# print("total_gain = ", total_gain)
# conjunto = H1 * H2 * H3 * H4 * H5 * total_gain
#
# mag, pha, w = signal.bode(algebra.conseguir_tf(conjunto, s),1e6)
# total_gain = -mag[0]
print("total_gain = ", total_gain)
#
#
transf = [H1, H2, H3, H4, H5, H6]

transf = [etapas.EtapaEA(i, s) for i in transf]
transf[0].name = "1"
transf[1].name = "2"
transf[2].name = "3"
transf[3].name = "4"
transf[4].name = "5"
transf[5].name = "6"

for i in transf:
    i.getMaxMinGain()

# transf[0].gain = -30
# transf[1].gain = -7.23513357298833
# transf[2].gain = 0
# transf[3].gain = 0
# transf[4].gain = 0

for it in itertools.permutations(transf):
    #setGain(it, total_gain)
    #print("Rango dinamico : ", computeRD(it)[2])
    for i in it:
        i.getMaxMinGain()
    setGain(it, total_gain)

    print("Rango dinamico : ", computeRD(it)[2])

    print("Gains : ")
    for j in it:
       print("T["+j.name+"] " ,j.gain)
