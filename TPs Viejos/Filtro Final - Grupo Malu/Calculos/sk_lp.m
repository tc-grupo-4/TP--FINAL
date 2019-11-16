clearvars;

Q = 1.68;
f0 = 2.2e3;
c2 = 10e-9;
c1 = c2;

n = (2*Q)^2;
r1 = 1/(4*pi()*f0*Q*c2);
r2 = n*r1;

q = sqrt(r1*r2*c1*c2)/(r1*(c1+c2));
f = 1/(2*pi()*sqrt(r1*r2*c1*c2));