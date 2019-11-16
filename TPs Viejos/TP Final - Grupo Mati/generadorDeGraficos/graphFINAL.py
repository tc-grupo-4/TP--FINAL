import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from mpldatacursor import datacursor

#OBTENCION DE MEDICIONES
medE1 = pd.read_csv("med_etapa1.csv")
medE2 = pd.read_csv("med_etapa2.csv")
medE3 = pd.read_csv("med_etapa3.csv")
medE4 = pd.read_csv("med_etapa4.csv")
medE5 = pd.read_csv("med_etapa5.csv")
medE6 = pd.read_csv("med_etapa6.csv")
medTOTAL = pd.read_csv("med_total.csv")

#medE1_mag = 20*(np.log10(medE1["v2"]/medE1["v1"]))
#medE2_mag = 20*(np.log10(medE2["v2"]/medE2["v1"]))
#medE3_mag = 20*(np.log10(medE3["v2"]/medE3["v1"]))
#medE4_mag = 20*(np.log10(medE4["v2"]/medE4["v1"]))
#medE5_mag = 20*(np.log10(medE5["v2"]/medE5["v1"]))
#medE6_mag = 20*(np.log10(medE6["v2"]/medE6["v1"]))
#medTOTAL_mag = 20*(np.log10(medTOTAL["v2"]/medTOTAL["v1"]))

#OBTENCION DE SIMULACIONES
simE1 = pd.read_csv("sim_etapa1.csv")
simE2 = pd.read_csv("sim_etapa2.csv")
simE3 = pd.read_csv("sim_etapa3.csv")
simE4 = pd.read_csv("sim_etapa4.csv")
simE5 = pd.read_csv("sim_etapa5.csv")
simE6 = pd.read_csv("sim_etapa6.csv")
simTOTAL = pd.read_csv("sim_total.csv")

plt.figure(1) #GRAFICO DE ETAPA 1
plt.xlabel("Frecuencia (Hz)")
plt.ylabel("Magnitud (dB)")
plt.title("Diagrama de Magnitud - Etapa 1")
plt.semilogx(simE1["f"], simE1["mag"], label='simulado')
plt.grid(True)
plt.semilogx(medE1["f"], medE1["v2"], label='medido')
plt.xticks()
plt.yticks()
plt.legend(loc = 'lower right')
datacursor(formatter="f:{x:.2f} Hz\n mag:{y:.2f} dB".format, display='multiple', draggable=True)

plt.figure(2) #GRAFICO DE ETAPA 2
plt.xlabel("Frecuencia (Hz)")
plt.ylabel("Magnitud (dB)")
plt.title("Diagrama de Magnitud - Etapa 2")
plt.semilogx(simE2["f"], simE2["mag"], label='simulado')
plt.grid(True)
plt.semilogx(medE2["f"], medE2["v2"], label='medido')
plt.xticks()
plt.yticks()
plt.legend(loc = 'lower right')
datacursor(formatter="f:{x:.2f} Hz\n mag:{y:.2f} dB".format, display='multiple', draggable=True)

plt.figure(3) #GRAFICO DE ETAPA 3
plt.xlabel("Frecuencia (Hz)")
plt.ylabel("Magnitud (dB)")
plt.title("Diagrama de Magnitud - Etapa 3")
plt.semilogx(simE3["f"], simE3["mag"], label='simulado')
plt.grid(True)
plt.semilogx(medE3["f"], medE3["v2"], label='medido')
plt.xticks()
plt.yticks()
plt.legend(loc = 'lower right')
datacursor(formatter="f:{x:.2f} Hz\n mag:{y:.2f} dB".format, display='multiple', draggable=True)

plt.figure(4) #GRAFICO DE ETAPA 4
plt.xlabel("Frecuencia (Hz)")
plt.ylabel("Magnitud (dB)")
plt.title("Diagrama de Magnitud - Etapa 4")
plt.semilogx(simE4["f"], simE4["mag"], label='simulado')
plt.grid(True)
plt.semilogx(medE4["f"], medE4["v2"], label='medido')
plt.xticks()
plt.yticks()
plt.legend(loc = 'lower right')
datacursor(formatter="f:{x:.2f} Hz\n mag:{y:.2f} dB".format, display='multiple', draggable=True)

plt.figure(5) #GRAFICO DE ETAPA 5
plt.xlabel("Frecuencia (Hz)")
plt.ylabel("Magnitud (dB)")
plt.title("Diagrama de Magnitud - Etapa 5")
plt.semilogx(simE5["f"], simE5["mag"], label='simulado')
plt.grid(True)
plt.semilogx(medE5["f"], medE5["v2"], label='medido')
plt.xticks()
plt.yticks()
plt.legend(loc = 'lower right')
datacursor(formatter="f:{x:.2f} Hz\n mag:{y:.2f} dB".format, display='multiple', draggable=True)

plt.figure(6) #GRAFICO DE ETAPA 6
plt.xlabel("Frecuencia (Hz)")
plt.ylabel("Magnitud (dB)")
plt.title("Diagrama de Magnitud - Etapa 6")
plt.semilogx(simE6["f"], simE6["mag"], label='simulado')
plt.grid(True)
plt.semilogx(medE6["f"], medE6["v2"], label='medido')
plt.xticks()
plt.yticks()
plt.legend(loc = 'lower right')
datacursor(formatter="f:{x:.2f} Hz\n mag:{y:.2f} dB".format, display='multiple', draggable=True)


plt.figure(7) #GRAFICO DE ETAPAS JUNTAS
plt.xlabel("Frecuencia (Hz)")
plt.ylabel("Magnitud (dB)")
plt.title("Diagrama de Magnitud - Etapas en Cascada")
plt.semilogx(simTOTAL["f"], simTOTAL["mag"], label='simulado')
plt.grid(True)
plt.semilogx(medTOTAL["f"], medTOTAL["v2"], label='medido')
plt.xticks()
plt.yticks()
plt.legend(loc = 'lower right')
datacursor(formatter="f:{x:.2f} Hz\n mag:{y:.2f} dB".format, display='multiple', draggable=True)

plt.show()




