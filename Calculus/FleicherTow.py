
def FTHigh(k,wo,Q,R8,R3,R7,C1,C2):
    R2 = R8 / (wo**2 * R3*R7*C1*C2)
    R1 = Q/(C1*wo)
    R6 = R8/k#-R8/k
    R4 = R1 * R6/R7
    temp = {'R1':R1,'R2':R2, 'R3':R3, 'R4':R4, 'R6':R6, 'R7':R7, 'R8':R8, 'C1':C1, 'C2':C2}
    return temp

def FTBand(k,wo,Q,R8,R3,R7,C1,C2):
    R2 = R8 / (wo**2 * R3*R7*C1*C2)
    R1 = Q/(C1*wo)
    R4 = R1*R8/(k*R7)
    temp = {'R1':R1,'R2':R2, 'R3':R3, 'R4':R4, 'R7':R7, 'R8':R8, 'C1':C1, 'C2':C2}
    return temp

def FTLow(k,wo,Q,R8,R3,R7,C1,C2):
    R2 = R8 / (wo**2 * R3*R7*C1*C2)
    R1 = Q/(C1*wo)
    R5 = R2/k#-R2/k 
    temp = {'R1':R1,'R2':R2, 'R3':R3,'R5':R5, 'R7':R7, 'R8':R8, 'C1':C1, 'C2':C2}
    return temp
    