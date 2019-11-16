clearvars;
clear;
clc;
syms r1 r2 c1 c2 s;

w0 = 1/sqrt(r1*r2*c1*c2);
Q = sqrt(r1*r2*c1*c2)/(r1*(c1+c2));

vars = [w0, Q];
nvars = size(vars,2);
params = [r1, r2, c1, c2];
nparams = size(params,2);

for i=1:nvars
    for j=1:nparams
        sens(i,j) = simplify(params(j)/vars(i) * diff(vars(i), params(j)));
		sens(i,j)
		latex(sens(i,j))
		sprintf('i = %d, j = %d ',i,j)
    end    
end

%{
		w0:

	r1: 
-1/2
- \frac{1}{2}
	r2: 
-1/2
- \frac{1}{2}
	c1: 
-1/2
- \frac{1}{2}
	c2: 
-1/2
- \frac{1}{2}
		Q:

	r1: 
-1/2
- \frac{1}{2}
	r2: 
1/2
\frac{1}{2}
	c1: 
-(c1 - c2)/(2*(c1 + c2))
-\frac{\mathrm{c1} - \mathrm{c2}}{2\, \left(\mathrm{c1} + \mathrm{c2}\right)}
remplazando por c1 = y c2 = 
obtengo 
	c2: 
(c1 - c2)/(2*(c1 + c2))
\frac{\mathrm{c1} - \mathrm{c2}}{2\, \left(\mathrm{c1} + \mathrm{c2}\right)}



%}
