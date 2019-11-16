% Filtro final - Orden 10 Legendre %
clc;
s = tf('s');
wp = 2*pi*13250;
SHP = wp/s;

H1 = 1/(SHP^2 + SHP*0.5548 + 0.2702);
H2 = 1/(SHP^2 + SHP*0.0918 + 0.9870);
H3 = 1/(SHP^2 + SHP*0.4284 + 0.5282);
H4 = 1/(SHP^2 + SHP*0.2650 + 0.8013);
H5 = 1/(SHP^2 + SHP*0.6344 + 0.1218);
H = H1*H2*H3*H4*H5;

[nH1,dH1] = tfdata(H1,'v');
[nH2,dH2] = tfdata(H2,'v');
[nH3,dH3] = tfdata(H3,'v');
[nH4,dH4] = tfdata(H4,'v');
[nH5,dH5] = tfdata(H5,'v');

Wo1 = sqrt(dH1(3)/dH1(1));
Q1 = Wo1*dH1(1)/dH1(2);

Wo2 = sqrt(dH2(3)/dH2(1));
Q2 = Wo2*dH2(1)/dH2(2);

Wo3 = sqrt(dH3(3)/dH3(1));
Q3 = Wo3*dH3(1)/dH3(2);

Wo4 = sqrt(dH4(3)/dH4(1));
Q4 = Wo4*dH4(1)/dH4(2);

Wo5 = sqrt(dH5(3)/dH5(1));
Q5 = Wo5*dH5(1)/dH5(2);

% Circuito 1

C_1 = 3.3e-9
R_1 = 1/(Wo1*C_1)
R_A1 = 2.2e3
R_B1 = (2-(1/Q1))*R_A1

% Circuito 2

C_2 = 1e-9
R2_2 = 3*(Q2)/(Wo2*C_2)
R1_2 = 1/(((Wo2)^2) * R2_2 * (C_2)^2)
f_2 = Wo2 / (2*pi) 

% Circuito 3

C_3 = 3.9e-9
R_3 = 1/(Wo3*C_3)
R_A3 = 1e3
R_B3 = (2-(1/Q3))*R_A3

% Circuito 4

C_4 = 1e-9
R2_4 = 3*(Q4)/(Wo4*C_4)
R1_4 = 1/(((Wo4)^2) * R2_4 * (C_4)^2)
f_4 = Wo4 / (2*pi)

% Circuito 5

C_5 = 1.5e-9
R_5 = 1/((Wo5)*C_5)
R_A5 = 10e3
R_B5 = (2-(1/(Q5)))*R_A5

% Circuito Extra

C_6 = 1e-9
R_6 = 1/(2*pi*15000*C_6)
R_A6 = 10e3
R_B6 = (2-(1/(0.8)))*R_A6