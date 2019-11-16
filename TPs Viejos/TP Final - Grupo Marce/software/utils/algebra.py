import sympy as sp
import config
from scipy import signal
from decimal import *
from numpy import roots, nditer, log10, floor, pi, sqrt
from utils import compare


def round_sig(x, sig=2):
    return round(x, sig-int(floor(log10(abs(x))))-1)


### Funciones auxiliares para asistencia algebraica

def g(w):
    #print(w.evalf(subs={sp.I: 1j}))
    return w.evalf(subs={sp.I: 1j})


def get_rational_coeffs(expr, var):
    num, denom = expr.as_numer_denom()
    #print(num,denom)
    return [sp.Poly(num, var).all_coeffs(), sp.Poly(denom, var).all_coeffs()]

def expand_and_get_coef(exp, var):

    data = get_rational_coeffs(exp, var)

    #data[0] = [g(v) for v in data[0]]
    #data[1] = [g(v) for v in data[1]]

    return data


def getRoots(exp, var):
    data = get_rational_coeffs(exp, var)

    data[0] = roots(data[0])
    data[1] = roots(data[1])

    return data


def filterRealNegativeRoots(rootList):
    ans = []
    for i in nditer(rootList):
        if i.real < 0:
            ans.append(i)
    return ans


# Armamos un polinomio simbolico a partir de los polos y ceros
def armarPolinomino(polos, ceros, var, k=1):
    h = k
    for c in ceros:
        h = h * (var - c["value"]) / -c["value"]
    for p in polos:
        h = h * 1 / (var - p["value"]) * -p["value"]

    return h

# Obtenemos la funcion trasnferencia de scipy a partir de un polinomio en var

def conseguir_coef(exp, var):
    value = expand_and_get_coef(exp, var)

    my_subs = dict()
    my_subs[sp.I] = 1j

    for i in range(len(value[0])):
        value[0][i] = complex(value[0][i].evalf(subs=my_subs))
    for i in range(len(value[1])):
        value[1][i] = complex(value[1][i].evalf(subs=my_subs))

    return value

def conseguir_tf(exp, var, poles = []):

    value = expand_and_get_coef(exp, var)

    my_subs = dict()
    my_subs[sp.I] = 1j

    for i in range(len(value[0])):
        value[0][i] = complex(value[0][i].evalf(subs=my_subs))
    for i in range(len(value[1])):
        value[1][i] = complex(value[1][i].evalf(subs=my_subs))
    #print(value[0], value[1])

    tf = signal.lti(value[0], value[1])

    return tf

