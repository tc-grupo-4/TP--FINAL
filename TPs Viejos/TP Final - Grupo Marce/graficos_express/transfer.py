# coding=utf-8

# coding=utf-8
import sympy as sp
from utils import algebra
from scipy import signal

s = sp.symbols("s")


R1 = 172e3
RA = 10e3
RB = 2.2e3
K = 1+(RB/RA)
C = 1e-9
R2 = 172e3
a = 1

H1 = (a*K/(R1*R2*(C**2))) / ((s)**2 + s*(((1/R1)+((2-K)/R2))/(C)) + (1/(R1*R2*(C**2))))

R1 = 1.5e3
RA = 2.2e3
RB = 2e3
K = 1+(RB/RA)
C = 100e-9
R2 = 1.5e3
a = 1.5/2.2

H2 = (a*K/(R1*R2*(C**2))) / ((s)**2 + s*(((1/R1)+((2-K)/R2))/(C)) + (1/(R1*R2*(C**2))))

Cf = 100e-9
Rf = 1.8e3
Rr = 2.9e3

H3 = Rf/(Rr*(s*Cf*Rf+1))


bH = algebra.conseguir_tf(-H1*H2*H3, s)

R1 = 172e3
RA = 10e3
RB = 2.2e3
K = 1+(RB/RA)
C = 1e-9
R2 = 172e3
a = 1


bZin = algebra.conseguir_tf(R1/(a*(1-(H1*RA*(s*C*R2+1)/(RA+RB)))), s)


