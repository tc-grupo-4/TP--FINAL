clc;
clear;
syms R1;
syms R2;
syms R3;
syms R4;
syms C1;
syms C2;

w0 = 1/sqrt((R1*R2*C1*C2));
Q = (sqrt(R1*R2*C1*C2))/(R2*C2+R2*C1+R1*C2*(-R4/R3));

sensib(R1,w0)


