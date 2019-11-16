% Filtro final - Orden 10 Legendre & Butterworth - Intento 3 %
% Mas reestrictivo: Ap = 0.5dB y As = 50dB
% Resulta orden n = 8 + 4
clc;

Wo1 = 2*pi*12584.30;
Q1 = 5.04;
Wo2 = 2*pi*14216.39;
Q2 = 1.55;
Wo3 = 2*pi*17885.54;
Q3 = 0.81;
Wo4 = 2*pi*22755.41;
Q4 = 0.53;

Wo5 = 2*pi*15375.64;
Q5 = 1.31;
Wo6 = 2*pi*15375.64;
Q6 = 0.54;

% Circuito 1

% C_1 = 1e-9;
% R2_1 = 3*(Q1)/(Wo1*C_1);
% R1_1 = 1/(((Wo1)^2) * R2_1 * (C_1)^2);
% f_1 = Wo1 / (2*pi);

% Circuito1V2

C_12a = 1e-9;
R_12a = 1/(Wo1*C_12a);
R_3a = 1e3;
R_4a = R_3a*(2*Q1 - 1);
R_56a = 15e3;

% Circuito 2

C_2 = 5.6e-9;
R_2 = 1/(Wo2*C_2);
R_A2 = 1e3;
R_B2 = (2-(1/Q2))*R_A2;
f_2 = Wo2/(2*pi);

% Circuito2V2

% C_12b = 4.7e-9;
% R_12b = 1/(Wo2*C_12b);
% R_3b = 2.2e3 ;
% R_4b = R_3b*(2*Q2 - 1);
% R_56b = 15e3;

% Circuito 3

C_3 = 5.6e-9;
R_3 = 1/(Wo3*C_3);
R_A3 = 10e3;
R_B3 = (2-(1/Q3))*R_A3;
f_3 = Wo3/(2*pi);

% Circuito 4

C_4 = 3.3e-9;
R_4 = 1/(Wo4*C_4);
R_A4 = 10e3;
R_B4 = (2-(1/Q4))*R_A4;
f_4 = Wo4/(2*pi);

% Circuito 5

C_5 = 3.3e-9;
R_5 = 1/(Wo5*C_5);
R_A5 = 10e3;
R_B5 = (2-(1/Q5))*R_A5;
f_5 = Wo5/(2*pi);

% Circuito 6

C_6 = 2.2e-9;
R_6 = 1/(Wo6*C_6);
R_A6 = 10e3;
R_B6 = (2-(1/Q6))*R_A6;
f_6 = Wo6/(2*pi);