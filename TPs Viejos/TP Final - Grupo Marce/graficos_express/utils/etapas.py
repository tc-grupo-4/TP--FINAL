from utils.algebra import conseguir_tf, conseguir_coef, compare, round_sig
from numpy import pi, sqrt, logspace, log10
import sympy as sp
from scipy import signal
import config

# Aqui esta el codigo que administra las etapas formadas por polos y ceros


# En esta clase tenemos una entidad que contine solo etapas
class DataEtapas:
    def __init__(self, polos, ceros):
        self.polos = polos
        self.ceros = ceros
        self.conjunto = dict()
        self.index = 0
        for i in self.polos:
            i.setIndex(self.index)
            self.conjunto[self.index] = {
                "tipo": "polo",
                "contenido": i,
                "index": self.index
            }
            #i.invertTransfer()
            self.index += 1
        for i in self.ceros:
            i.setIndex(self.index)
            self.conjunto[self.index] = {
                "tipo": "cero",
                "contenido": i,
                "index": self.index
            }
            self.index += 1


class Etapa: ### Solo tiene un polo o un cero, no es una etapa completa, la llamo "etapa primaria@
    index = None

    def __init__(self, w0, xi, order, transfer_expression, var):
        self.f0 = w0 / 2 / pi
        if -1e-5 < xi < 1e-5:
            self.q = 1e5
        else:
            self.q = 1 / (2 * xi)
        self.xi = xi
        self.order = order
        self.transfer_expression = transfer_expression
        self.var = var

        self.k = 1

        # Si order=1, q no tiene sentido
        # Si f0 = -1, la singularidad esta en el origen
        # Si Q > 100, se considera una singularidad en el eje jw

    def invertTransfer(self):
        self.transfer_expression = 1 / self.transfer_expression

    def getType(self):
        if self.f0 < 0:
            tipo = "origen"
        elif self.q > 100 or self.q < -100:
            tipo = "conjugados, eje jw"
        elif self.order == 2:
            tipo = "conjugados"
        else:
            tipo = "real"
        return tipo

    def setIndexes(self, i1, i2):
        self.ind1 = i1
        self.ind2 = i2

    def setIndex(self, index):
        self.index = index

    def show(self):
        print("Etapa de orden 2:")
        print("w0 = ", self.w0, " q = ", self.q)


# obtenemos el cociente entre la el maximo y el minimo del producto de dos etapas primarias
def getEtapa(polo, cero, min_freq, max_freq):
    if cero:
        etapa = EtapaEE([{"tipo": "polo", "contenido": polo},
                         {"tipo": "cero", "contenido": cero}
                         ], -1, 1, polo.var)
    else:
        etapa = EtapaEE([{"tipo": "polo", "contenido": polo}],
                        -1, 1, polo.var)

    if etapa.corrupto:
        return None

    etapa.computarMinMaxGain(min_freq, max_freq)

    return etapa


def getDualZero(var,c1,c2):
    e = Etapa(-1, -1, 2, var ** 2, var)
    e.setIndexes(c1, c2)
    return e

def getSingleZero(var, c):
    e = Etapa(-1, -1, 1, var , var)
    e.setIndex(c)
    return e

class EtapaEE:  # etapa compuesta por un polo de orden dos o uno mas uno cero de orden 1 o 2, es una "etapa compuesta"
    def __init__(self, partes, index, gain, var):
        self.polos = []
        self.ceros = []
        self.index = index
        self.gain = gain
        self.minGain, self.maxGain = None, None  # ganancia minima y maxima si la constante es unitaria
        self.transfer_expression = 1
        self.var = var
        self.tf = None
        self.cero = None
        self.polo = None

        orderPolos = 0
        orderCeros = 0

        for comp in partes:
            if comp["tipo"] == "polo":
                self.polos.append(comp["contenido"])
                orderPolos += comp["contenido"].order
            else:
                self.ceros.append(comp["contenido"])
                orderCeros += comp["contenido"].order

        self.corrupto = 0
        if orderPolos >= 3 or orderPolos == 0:
            self.corrupto = 1
            return
        if orderCeros >= 3:
            self.corrupto = 1
            return

        if len(self.polos) == 2:
            t1 = self.polos[0].getType()
            t2 = self.polos[1].getType()

            if t1 == "origen" and t2 == "origen":
                self.polos = [Etapa(-1, -1, 2, self.var**2, self.var)]

        if len(self.ceros) == 2:
            t1 = self.ceros[0].getType()
            t2 = self.ceros[1].getType()

            if t1 == "origen" and t2 == "origen":
                self.ceros = [Etapa(-1, -1, 2, self.var**2, self.var)]

        self.polo = self.polos[0]
        if len(self.ceros) > 0:
            self.cero = self.ceros[0]
        else:
            self.cero = None

        if self.cero:
            #print("cero:",self.cero.transfer_expression)
            self.transfer_expression *= self.cero.transfer_expression
        if self.polo:
            #print("polo:", self.polo.transfer_expression)
            self.transfer_expression /= self.polo.transfer_expression

    def getCeros(self):

        if self.cero and self.cero.order == 2 and self.cero.getType() == "origen":
            e1 = Etapa(-1, -1, 2, self.var, self.var)
            e2 = Etapa(-1, -1, 2, self.var, self.var)

            e1.setIndex(self.cero.ind1)
            e2.setIndex(self.cero.ind2)

            return [e1, e2]
        return self.ceros

    def computarMinMaxGain(self, min_freq, max_freq): # conseguir minima y maxima ganancia de la etapa dado un rango de frecuencias
        self.tf = conseguir_tf(self.transfer_expression, self.var)

        w, mag, pha = signal.bode(self.tf, logspace(log10(min_freq), log10(max_freq), 10000))
        self.w = w
        self.mag = mag

        minGain = 1e8
        maxGain = -1e8

        for m in self.mag:
            minGain = min(minGain, m)
            maxGain = max(maxGain, m)

        self.minGain = minGain
        self.maxGain = maxGain

        if config.debug:
            print("Ganancia mínima:", minGain)
            print("Ganancia máxima:", maxGain)


def getSingText(singularidad):

    f0 = round_sig(singularidad.f0)

    if singularidad.f0 < 0:
        f0text = "origen"
    else:
        f0text = "f0 = " + str(f0) + "hz"

    if singularidad.q > 100:
        qText = "eje jw"

    elif singularidad.q == -0.5:
        if singularidad.order == 1:
            qText = "orden 1"
        else:
            qText = "orden 2"
    else:
        qText = "q = " + str(round_sig(singularidad.q))

    return f0text, qText

# obtener singularidades de primer y segundo orden a partir de polos o ceros
def getSing(data):
    print("data = ", data)
    s = sp.symbols("s")

    entidades = []
    etapas = []
    # tengo que armar los pares de polos complejos conjugados
    for i in range(len(data)):
        if compare(data[i].real, 0) and compare(data[i].imag, 0):
            etapas.append(Etapa(-1, -1, 1, s, s))
        elif data[i].imag < 0:
            entidades.append(data[i].real - data[i].imag * 1j)
        else:
            entidades.append(data[i].real + data[i].imag * 1j)
    entidades = sorted(entidades, key=lambda x: x.imag)

    # print("entidades = " , entidades)

    sing = []
    skip = 0

    for i in range(len(entidades)):
        if skip:
            skip = 0
            continue
        if i != len(entidades) - 1 and compare(entidades[i].imag, entidades[i + 1].imag):
            # por cada singularidad de segundo orden
            cong = entidades[i].real - entidades[i].imag * 1j
            mySing = {
                "order": 2,
                "exp": (s - entidades[i]) * (s - cong) / (-entidades[i]) / (-cong)
            }
            sing.append(mySing)

            skip = 1
        else:
            mySing = {
                "order": 1,
                "exp": (s - entidades[i]) / (-entidades[i])
            }
            sing.append(mySing)
    # print("sing = ",sing)

    for si in sing:
        if si["order"] == 2:
            exp = conseguir_coef(si["exp"], s)
            # print("exp = ",exp)

            w0 = sqrt(1 / exp[0][0].real)
            xi = exp[0][1].real * w0 / 2

            etapas.append(Etapa(w0, xi, 2, si["exp"], s))

        elif si["order"] == 1:
            exp = conseguir_coef(si["exp"], s)

            w0 = 1 / exp[0][0].real

            etapas.append(Etapa(w0, -1, 1, si["exp"],  s))

    return etapas
