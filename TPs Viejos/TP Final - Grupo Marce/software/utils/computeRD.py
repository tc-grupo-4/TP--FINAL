
from numpy import log10
from config import v_sat, v_ruido


def setGain(etapas , total_gain):
    othersGain = 0
    for i in range(len(etapas) - 1, 0, -1):
        kmax = etapas[i].maxGain
        kmin = etapas[i].minGain

        etapas[i].gain = (- kmin - kmax) / 2
        othersGain += etapas[i].gain

    etapas[0].gain = total_gain - othersGain


def computeRD(etapas):
    if len(etapas) == 0:
        return None

    v_max = 1e8
    v_min = v_ruido


    for fi in range(len(etapas[0].mag)):
        # para cada frecuencia limitar v max y v min
        product = 1

        for etapa_k in range(len(etapas)):
            etapa = etapas[etapa_k]
            product *= 10 ** ((etapa.mag[fi]+etapa.gain) / 20.0)

            v_max = min(v_max, v_sat / product)
            v_min = max(v_min, v_ruido / product)

    return v_max, v_min, 20 * log10(v_max / v_min)



