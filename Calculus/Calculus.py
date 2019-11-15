import sallenLow
import sallenHigh
import FleicherTow
import time

def exportToSpice(file, cellnumber,values):
    textList=[]
    index=0
    for key, value in values.items():
        index=index+1
        textList.append("TEXT "+str(384+300*cellnumber)+" "+str(736+index*50)+" Left 2 !.param "+str(key)+"_"+str(cellnumber)+" "+str(value))
    for line in textList:
        file.write(line)
        file.write("\n")
    return

ExportarLTSpice = True
Montecarlo = True

G1=-5.19
Q1=4.44
fo1 =12822.6
type1 = 'hp'

G2=-2.71
Q2=1.41
fo2 =9714.95
type2 = 'lp'


G3=-0.23
Q3=4.44
fo3 =1949.6
type3 = 'hp'


G4=24.61
Q4=0.93
fo4 =4999.9
type4 = 'lp'


G5=3.08
Q5=1.41
fo5 =2573.25
type5 = 'bp'



k1 = 10**(G1/20)
w1 = 2*3.14159*fo1
k2 = 10**(G2/20)
w2 = 2*3.14159*fo2
k3 = 10**(G3/20)
w3 = 2*3.14159*fo3
k4 = 10**(G4/20)
w4 = 2*3.14159*fo4
k5 = 10**(G5/20)
w5 = 2*3.14159*fo5

k = [k1,k2,k3,k4,k5]
w = [w1,w2,w3,w4,w5]
Q = [Q1,Q2,Q3,Q4,Q5]
typef = [type1,type2,type3,type4,type5]
data = []

for i in range(0,len(k)):
    if typef[i] == 'lp':
        data.append(FleicherTow.FTLow(k[i],w[i],Q[i],1e3,1e3,1e3,10e-9,10e-9))
    elif typef[i] == 'hp':
        data.append(FleicherTow.FTHigh(k[i],w[i],Q[i],1e3,1e3,1e3,10e-9,10e-9))
    elif typef[i] == 'bp':
        data.append(FleicherTow.FTBand(k[i],w[i],Q[i],1e3,1e3,1e3,10e-9,10e-9))

if ExportarLTSpice is True:
    timestr = time.strftime("%Y%m%d-%H%M%S")
    if Montecarlo is False:
        inF = open("simulation_template.asc", "r")
    else:
        inF = open("simulation_template2.asc", "r")
    outF=open("simulation_generated_"+timestr+".asc","w+")
    outF.write(inF.read())
    for i in range(0,len(data)):
        exportToSpice(outF,i+1,data[i])
    outF.close()
    inF.close()
print(typef)