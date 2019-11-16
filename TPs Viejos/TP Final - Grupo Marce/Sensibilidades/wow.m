clear;
clc;
% syms C1;
% syms C2;
% syms R1;
% syms R2;
% func = 1/sqrt(C1*C2*R1*R2);
% sensib(R2,func)

R1 = 12.22e3;
R2 = 12.22e3;
R3 = 1e3;
R4 = 14.46e3;
R5 = 15e3;
R6 = 15e3;
C1 = 1e-9;
C2 = C1;
Q = 11.58;

SQR4 = R4/(R4+R3);
SQR3 = -SQR4;
SQR5 = (Q/2)*((R5-R6)/(1+R4/R3))*(sqrt(R2*C2/(R5*R6*R1*C1)));
SQR6 = -SQR5;

