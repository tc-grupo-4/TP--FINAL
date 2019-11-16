
from mpldatacursor import datacursor


def make_datacursor(mode, filename, my_plt , fig):
    if mode == "mag":
        datacursor(display='multiple', tolerance=30, formatter="Freq: {x:.3e}  Hz \nAmp:{y:.1f} Db".format,
                   draggable=True)
    elif mode == "pha":
        datacursor(display='multiple', tolerance=30, formatter="Freq: {x:.3e}  Hz \nFase:{y:.1f} grados".format,
                   draggable=True)
    elif mode == "gd":
        datacursor(display='multiple', tolerance=0, formatter="Freq: {x:.3e}  Hz \nGd:{y:.3f} ms".format,
                   draggable=True)

    my_plt.minorticks_on()
    my_plt.grid(which='major', linestyle='-', linewidth=0.3, color='black')
    my_plt.grid(which='minor', linestyle=':', linewidth=0.1, color='black')

    my_plt.show()
    input("Press Enter ")

    fig.savefig(filename, dpi=300)
    my_plt.cla()
    my_plt.close()


def add_legend(my_mode, ax, my_plt):

    ax.minorticks_on()
    ax.grid(which='major', linestyle='-', linewidth=0.3, color='black')
    ax.grid(which='minor', linestyle=':', linewidth=0.1, color='black')

    my_plt.xlabel("Frecuencia (Hz)")
    if my_mode == "mag":
        my_plt.ylabel("Amplitud (dB)")
    elif my_mode == "pha":
        my_plt.ylabel("Fase (grados)")
    elif my_mode == "gd":
        my_plt.ylabel("Retardo de grupo (ms)")


def add_legend_zin(mode, ax, plt):

    ax.minorticks_on()
    ax.grid(which='major', linestyle='-', linewidth=0.3, color='black')
    ax.grid(which='minor', linestyle=':', linewidth=0.1, color='black')

    plt.xlabel("Frecuencia (Hz)")
    if mode == "mag":
        plt.ylabel("Impedancia (K $\Omega$)")
    else:
        plt.ylabel("Fase (grados)")


def make_datacursor_zin(mode, filename,my_plt , fig, ax):
    add_legend_zin(mode, ax, my_plt)

    if mode == "mag":
        datacursor(display='multiple', tolerance=30, formatter="Freq: {x:.3e}  Hz \nZin:{y:.1f} K $\Omega$".format,
                   draggable=True)
    else:
        datacursor(display='multiple', tolerance=30, formatter="Freq: {x:.3e}  Hz \nFase:{y:.1f} grados".format,
                   draggable=True)

    my_plt.show()
    input("Press Enter ")

    fig.savefig(filename, dpi=300)
    my_plt.cla()
    my_plt.close()

