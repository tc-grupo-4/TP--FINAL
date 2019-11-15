clearvars;
clear;
clc;
syms r1 r2 r3 r4 c1 c2 s;

w0 = 1/sqrt(r1*r2*c1*c2);
Q = sqrt(r1*r2*c1*c2)/(r1*(c1+c2) - c2*r2*r4/r3);
G = 1+r4/r3;

vars = [G, w0, Q];
nvars = size(vars,2);
params = [r1, r2, r3, r4, c1, c2];
nparams = size(params,2);

for i=1:nvars
    for j=1:nparams
        sens(i,j) = simplify(params(j)/vars(i) * diff(vars(i), params(j)));
		sens(i,j)
		latex(sens(i,j))
		sprintf('i = %d, j = %d ',i,j)
	end    
	clc;
end


%{
		G:

	r1:
0
0
	r2: 
0
0
	r3:
-r4/(r3 + r4)
-\frac{\mathrm{r4}}{\mathrm{r3} + \mathrm{r4}}
	r4: 
r4/(r3 + r4)
\frac{\mathrm{r4}}{\mathrm{r3} + \mathrm{r4}}
	c1:
0
0
	c2:
0
0
		w0:

	r1: 
-1/2
- \frac{1}{2}
	r2:  
-1/2
- \frac{1}{2}
	r3:
0
0
	r4: 
0
0
	c1:
-1/2
- \frac{1}{2}
	c2:
-1/2
- \frac{1}{2}

		Q:


	r1: 
-(c1*r1*r3 + c2*r1*r3 + c2*r2*r4)/(2*c1*r1*r3 + 2*c2*r1*r3 - 2*c2*r2*r4)
-\frac{\mathrm{c1}\, \mathrm{r1}\, \mathrm{r3} + \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3} + \mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}{2\, \mathrm{c1}\, \mathrm{r1}\, \mathrm{r3} + 2\, \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3} - 2\, \mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}
	r2:  
(c1*r1*r3 + c2*r1*r3 + c2*r2*r4)/(2*c1*r1*r3 + 2*c2*r1*r3 - 2*c2*r2*r4)
\frac{\mathrm{c1}\, \mathrm{r1}\, \mathrm{r3} + \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3} + \mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}{2\, \mathrm{c1}\, \mathrm{r1}\, \mathrm{r3} + 2\, \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3} - 2\, \mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}
	r3:
-(c2*r2*r4)/(r3*(r1*(c1 + c2) - (c2*r2*r4)/r3))
-\frac{\mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}{\mathrm{r3}\, \left(\mathrm{r1}\, \left(\mathrm{c1} + \mathrm{c2}\right) - \frac{\mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}{\mathrm{r3}}\right)}
	r4: 
(c2*r2*r4)/(r3*(r1*(c1 + c2) - (c2*r2*r4)/r3))
\frac{\mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}{\mathrm{r3}\, \left(\mathrm{r1}\, \left(\mathrm{c1} + \mathrm{c2}\right) - \frac{\mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}{\mathrm{r3}}\right)}
	c1:
-(c1*r1*r3 - c2*r1*r3 + c2*r2*r4)/(2*c1*r1*r3 + 2*c2*r1*r3 - 2*c2*r2*r4)
-\frac{\mathrm{c1}\, \mathrm{r1}\, \mathrm{r3} - \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3} + \mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}{2\, \mathrm{c1}\, \mathrm{r1}\, \mathrm{r3} + 2\, \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3} - 2\, \mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}
	c2:
(c1*r1*r3 - c2*r1*r3 + c2*r2*r4)/(2*c1*r1*r3 + 2*c2*r1*r3 - 2*c2*r2*r4)
\frac{\mathrm{c1}\, \mathrm{r1}\, \mathrm{r3} - \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3} + \mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}{2\, \mathrm{c1}\, \mathrm{r1}\, \mathrm{r3} + 2\, \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3} - 2\, \mathrm{c2}\, \mathrm{r2}\, \mathrm{r4}}

%}