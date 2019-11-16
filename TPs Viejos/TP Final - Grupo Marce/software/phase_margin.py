# coding=utf-8
import read_spice


def dsign(s1, s2):

    if s1 > 0 and s2 < 0:
        return 1

    if s1 < 0 and s2 > 0:
        return 1

    return 0

def compute_margin(filename):
    data = read_spice.read_file_spice(filename)

    phase_margin = None
    mag_margin = None

    for i in range(len(data["f"])-1):
        if dsign(data["abs"][i], data["abs"][i+1]):
            phase_margin = data["pha"][i]
        if dsign(data["pha"][i], data["pha"][i+1]):
            mag_margin = data["abs"][i]

    return {"pm": phase_margin, "mm": mag_margin}

