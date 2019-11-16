# coding=utf-8
import sympy as sp
from numpy import pi
from utils import etapas, algebra
import itertools
from scipy import signal
from numpy import logspace

def veces(v):
    return 10 ** (v/20.0)

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

H1 = veces(-0.10074052126957483) * s**2/(s**2 + s*Wo1/Q1 + Wo1**2)
H2 = veces(-0.10947355039605151)*s**2/(s**2 + s*Wo2/Q2 + Wo2**2)
H3 = veces(-0.12928908650773577)*s**2/(s**2 + s*Wo3/Q3 + Wo3**2)
H4 = veces(-0.1434825614451729)*s**2/(s**2 + s*Wo4/Q4 + Wo4**2)
H5 = veces(-0.035653959985164595)*s**2/(s**2 + s*Wo5/Q5 + Wo5**2)
H6 = veces(0.5186397040040062)*s**2/(s**2 + s*Wo6/Q6 + Wo6**2)


H = [H1, H2, H3, H4, H5, H6]

for i in range(len(H)):
    if i != 0:
        H[i] = H[i-1] * H[i]
for i in range(len(H)):
    H[i] = algebra.conseguir_tf(H[i], s)

