clearvars;
clear;
clc;
syms r1 r2 r3 r4 ra rb c1 c2 s;

zeq = r4 / (1 + s*c1*r4);

A = s*c2*r2*ra/rb;
H = simplify(-zeq / r3 / (A + zeq/r1))
latex(H)
pretty(H)
