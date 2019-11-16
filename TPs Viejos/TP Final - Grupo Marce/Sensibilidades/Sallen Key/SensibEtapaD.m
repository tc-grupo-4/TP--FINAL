clear;
clc;
R1 = 2.47e3;
R2 = R1;
R3 = 1.5e3;
R4 = 1.74e3;
C1=3.3e-9;
C2 = C1;


SQR1 = (C1*R2*R3 + C2*R1*R4 + C2*R2*R3)/(2*C1*R2*R3 - 2*C2*R1*R4 + 2*C2*R2*R3)
SQR2 =-(C1*R2*R3 + C2*R1*R4 + C2*R2*R3)/(2*C1*R2*R3 - 2*C2*R1*R4 + 2*C2*R2*R3);
SQR3 = -(C2*R1*R4)/(C1*R2*R3 - C2*R1*R4 + C2*R2*R3);
SQR4 = (C2*R1*R4)/(C1*R2*R3 - C2*R1*R4 + C2*R2*R3);
SQC1 = -(C1*R2*R3 + C2*R1*R4 - C2*R2*R3)/(2*C1*R2*R3 - 2*C2*R1*R4 + 2*C2*R2*R3);
SQC2 = (C1*R2*R3 + C2*R1*R4 - C2*R2*R3)/(2*C1*R2*R3 - 2*C2*R1*R4 + 2*C2*R2*R3);

fprintf('%f \n%f \n%f \n%f \n%f \n%f \n',SQR1,SQR2,SQR3,SQR4,SQC1,SQC2);