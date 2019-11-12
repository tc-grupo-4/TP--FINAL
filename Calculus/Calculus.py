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
Montecarlo = False

data1 = FleicherTow.FTLow(   0.050699, 2*3.142*9715.92 ,1.41, 1e3,1e3,1e3,10e-9,10e-9)
data2 = FleicherTow.FTHigh(  0.88511 , 2*3.142*1953.46 ,4.44, 1e3,1e3,1e3,10e-9,10e-9)
data3 = FleicherTow.FTBand(  5.41377 , 2*3.142*2577.97 ,1.41, 1e3,1e3,1e3,10e-9,10e-9)
data4 = sallenLow.calcValues(33.075,   2*3.142*5004.73 ,0.93, 10e3,1e3,10e-9)
data5 = FleicherTow.FTHigh(  1.1776 ,  2*3.142*12822   ,4.44, 1e3,1e3,1e3,10e-9,10e-9)


if ExportarLTSpice is True:
    timestr = time.strftime("%Y%m%d-%H%M%S")
    if Montecarlo is False:
        inF = open("simulation_template.asc", "r")
    else:
        inF = open("simulation_template2.asc", "r")
    outF=open("simulation_generated_"+timestr+".asc","w+")
    outF.write(inF.read())
    exportToSpice(outF,1,data1)
    exportToSpice(outF,2,data2)
    exportToSpice(outF,3,data3)
    exportToSpice(outF,4,data4)
    exportToSpice(outF,5,data5)
    outF.close()
    inF.close()