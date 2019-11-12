import numpy as np

def calcValues(k,wo,Q,R,Rb,C1):
    
    if k >= 1:
        Ra = (k-1)*Rb
    else:
        return "Error"
    
    C2 = (1/(R*wo*Q) - C1)/(1-Ra/Rb)
    temp = {'Ra':Ra , 'Rb': Rb , 'C1':C1 , 'C2':C2, 'R1': R, 'R2':R}
    return temp
