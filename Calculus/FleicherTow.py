from eseries import find_nearest, E12,E24,E48


def FTHigh(k,wo,Q,R8,R3,R7,C1,C2):
    R2 = R8 / (wo**2 * R3*R7*C1*C2)
    R2 = find_nearest(E24,R2)
    R1 = Q/(C1*wo)
    R1 = find_nearest(E24,R1)
    R6 = R8/k#-R8/k
    R6 = find_nearest(E24,R6)
    R4 = R1 * R6/R7
    R4 = find_nearest(E24,R4)
    temp = {'R1':R1,'R2':R2, 'R3':R3, 'R4':R4, 'R6':R6, 'R7':R7, 'R8':R8, 'C1':C1, 'C2':C2}
    return temp

def FTBand(k,wo,Q,R8,R3,R7,C1,C2):
    R2 = R8 / (wo**2 * R3*R7*C1*C2)
    R2 = find_nearest(E24,R2)
    R1 = Q/(C1*wo)
    R1 = find_nearest(E24,R1)
    R4 = R1*R8/(k*R7)
    R4 = find_nearest(E24,R4)
    temp = {'R1':R1,'R2':R2, 'R3':R3, 'R4':R4, 'R7':R7, 'R8':R8, 'C1':C1, 'C2':C2}
    return temp

def FTLow(k,wo,Q,R8,R3,R7,C1,C2):
    R2 = R8 / (wo**2 * R3*R7*C1*C2)
    R2 = find_nearest(E24,R2)
    R1 = Q/(C1*wo)
    R1 = find_nearest(E24,R1)
    R5 = R2/k#-R2/k 
    R5 = find_nearest(E24,R5)
    temp = {'R1':R1,'R2':R2, 'R3':R3,'R5':R5, 'R7':R7, 'R8':R8, 'C1':C1, 'C2':C2}
    return temp
    