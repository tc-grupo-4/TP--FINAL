clearvars;
clear;
clc;
syms r1 r2 r3 r4 ra rb c1 c2 k s;

k = 1+rb/ra;
w0 = sqrt((1+r1/r3)/(r1*r2*c1*c2));
% pretty(w0)
% latex(w0)
Q = sqrt(1+r1/r3)/( (1+ (1-k)*r1/r3) *sqrt(r2*c2/r1/c1) + sqrt(r2*c1/r2/c1) + sqrt(r1*c1/r2/c2) );
% pretty(Q)
% latex(Q)
G = k/(1+ (1-k)*r1/r3 + (1+c1/c2)*r1/r2);
pretty(G)
latex(G)

vars = [G, w0, Q];
nvars = size(vars,2);
params = [r1, r2, r3, r4, ra, rb, c1, c2];
nparams = size(params,2);

for i=1:nvars
    for j=1:nparams
        sens(i,j) = simplify(params(j)/vars(i) * diff(vars(i), params(j)));
		latex(sens(i,j))
		sprintf('i = %d, j = %d ',i,j)
    end    
end
%{
	G:

r1:
 -(r1*((c1/c2 + 1)/r2 - rb/(r3*ra)))/((r1*(c1/c2 + 1))/r2 - (r1*rb)/(r3*ra) + 1)
r2: (r1*(c1/c2 + 1))/(r2*((r1*(c1/c2 + 1))/r2 - (r1*rb)/(r3*ra) + 1))
r3: -(r1*rb)/(r3*ra*((r1*(c1/c2 + 1))/r2 - (r1*rb)/(r3*ra) + 1))
r4: 0
ra: -(ra*rb*(c1*r1*r3 + c2*r1*r2 + c2*r1*r3 + c2*r2*r3))/((ra + rb)*(c1*r1*r3*ra + c2*r1*r3*ra + c2*r2*r3*ra - c2*r1*r2*rb))
rb: (ra*rb*(c1*r1*r3 + c2*r1*r2 + c2*r1*r3 + c2*r2*r3))/((ra + rb)*(c1*r1*r3*ra + c2*r1*r3*ra + c2*r2*r3*ra - c2*r1*r2*rb))
c1: -(c1*r1)/(c2*r2*((r1*(c1/c2 + 1))/r2 - (r1*rb)/(r3*ra) + 1))
c2: (c1*r1)/(c2*r2*((r1*(c1/c2 + 1))/r2 - (r1*rb)/(r3*ra) + 1))

	w0:

r1: -r3/(2*(r1 + r3))
r2: -1/2
r3: -r1/(2*(r1 + r3))
r4: 0
ra: 0 
rb: 0 
c1: -1/2
c2: -1/2

	Q:

r1: 
-(r1*(((r1/r3 + 1)^(1/2)*(c1/(2*c2*r2*((c1*r1)/(c2*r2))^(1/2)) - (rb*((c2*r2)/(c1*r1))^(1/2))/(r3*ra) + (c2*r2*((r1*rb)/(r3*ra) - 1))/(2*c1*r1^2*((c2*r2)/(c1*r1))^(1/2))))/(((c1*r1)/(c2*r2))^(1/2) - ((r1*rb)/(r3*ra) - 1)*((c2*r2)/(c1*r1))^(1/2) + 1)^2 - 1/(2*r3*(r1/r3 + 1)^(1/2)*(((c1*r1)/(c2*r2))^(1/2) - ((r1*rb)/(r3*ra) - 1)*((c2*r2)/(c1*r1))^(1/2) + 1)))*(((c1*r1)/(c2*r2))^(1/2) - ((r1*rb)/(r3*ra) - 1)*((c2*r2)/(c1*r1))^(1/2) + 1))/(r1/r3 + 1)^(1/2)
r2: (r2*((c2*((r1*rb)/(r3*ra) - 1))/(2*c1*r1*((c2*r2)/(c1*r1))^(1/2)) + (c1*r1)/(2*c2*r2^2*((c1*r1)/(c2*r2))^(1/2))))/(((c1*r1)/(c2*r2))^(1/2) - ((r1*rb)/(r3*ra) - 1)*((c2*r2)/(c1*r1))^(1/2) + 1)
r3: -(r1*(r3*ra + r3*ra*((c1*r1)/(c2*r2))^(1/2) + r3*ra*((c2*r2)/(c1*r1))^(1/2) + r1*rb*((c2*r2)/(c1*r1))^(1/2) + 2*r3*rb*((c2*r2)/(c1*r1))^(1/2)))/(2*(r1 + r3)*(r3*ra + r3*ra*((c1*r1)/(c2*r2))^(1/2) + r3*ra*((c2*r2)/(c1*r1))^(1/2) - r1*rb*((c2*r2)/(c1*r1))^(1/2)))
r4: 0
ra: -(r1*rb*((c2*r2)/(c1*r1))^(1/2))/(r3*ra*(((c1*r1)/(c2*r2))^(1/2) - ((r1*rb)/(r3*ra) - 1)*((c2*r2)/(c1*r1))^(1/2) + 1))
rb: (r1*rb*((c2*r2)/(c1*r1))^(1/2))/(r3*ra*(((c1*r1)/(c2*r2))^(1/2) - ((r1*rb)/(r3*ra) - 1)*((c2*r2)/(c1*r1))^(1/2) + 1))
c1: -(c1*(r1/(2*c2*r2*((c1*r1)/(c2*r2))^(1/2)) + (c2*r2*((r1*rb)/(r3*ra) - 1))/(2*c1^2*r1*((c2*r2)/(c1*r1))^(1/2))))/(((c1*r1)/(c2*r2))^(1/2) - ((r1*rb)/(r3*ra) - 1)*((c2*r2)/(c1*r1))^(1/2) + 1)
c2: (c2*((r2*((r1*rb)/(r3*ra) - 1))/(2*c1*r1*((c2*r2)/(c1*r1))^(1/2)) + (c1*r1)/(2*c2^2*r2*((c1*r1)/(c2*r2))^(1/2))))/(((c1*r1)/(c2*r2))^(1/2) - ((r1*rb)/(r3*ra) - 1)*((c2*r2)/(c1*r1))^(1/2) + 1)
%}



%{
	G:

r1: 
-\frac{\mathrm{r1}\, \left(\frac{\frac{\mathrm{c1}}{\mathrm{c2}} + 1}{\mathrm{r2}} - \frac{\mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}}\right)}{\frac{\mathrm{r1}\, \left(\frac{\mathrm{c1}}{\mathrm{c2}} + 1\right)}{\mathrm{r2}} - \frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} + 1}
r2:
\frac{\mathrm{r1}\, \left(\frac{\mathrm{c1}}{\mathrm{c2}} + 1\right)}{\mathrm{r2}\, \left(\frac{\mathrm{r1}\, \left(\frac{\mathrm{c1}}{\mathrm{c2}} + 1\right)}{\mathrm{r2}} - \frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} + 1\right)}
r3:
-\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}\, \left(\frac{\mathrm{r1}\, \left(\frac{\mathrm{c1}}{\mathrm{c2}} + 1\right)}{\mathrm{r2}} - \frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} + 1\right)}
r4: 
0
ra: 
-\frac{\mathrm{ra}\, \mathrm{rb}\, \left(\mathrm{c1}\, \mathrm{r1}\, \mathrm{r3} + \mathrm{c2}\, \mathrm{r1}\, \mathrm{r2} + \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3} + \mathrm{c2}\, \mathrm{r2}\, \mathrm{r3}\right)}{\left(\mathrm{ra} + \mathrm{rb}\right)\, \left(\mathrm{c1}\, \mathrm{r1}\, \mathrm{r3}\, \mathrm{ra} + \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3}\, \mathrm{ra} + \mathrm{c2}\, \mathrm{r2}\, \mathrm{r3}\, \mathrm{ra} - \mathrm{c2}\, \mathrm{r1}\, \mathrm{r2}\, \mathrm{rb}\right)}
rb: 
\frac{\mathrm{ra}\, \mathrm{rb}\, \left(\mathrm{c1}\, \mathrm{r1}\, \mathrm{r3} + \mathrm{c2}\, \mathrm{r1}\, \mathrm{r2} + \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3} + \mathrm{c2}\, \mathrm{r2}\, \mathrm{r3}\right)}{\left(\mathrm{ra} + \mathrm{rb}\right)\, \left(\mathrm{c1}\, \mathrm{r1}\, \mathrm{r3}\, \mathrm{ra} + \mathrm{c2}\, \mathrm{r1}\, \mathrm{r3}\, \mathrm{ra} + \mathrm{c2}\, \mathrm{r2}\, \mathrm{r3}\, \mathrm{ra} - \mathrm{c2}\, \mathrm{r1}\, \mathrm{r2}\, \mathrm{rb}\right)}
c1: 
-\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}\, \left(\frac{\mathrm{r1}\, \left(\frac{\mathrm{c1}}{\mathrm{c2}} + 1\right)}{\mathrm{r2}} - \frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} + 1\right)}
c2: 
\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}\, \left(\frac{\mathrm{r1}\, \left(\frac{\mathrm{c1}}{\mathrm{c2}} + 1\right)}{\mathrm{r2}} - \frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} + 1\right)}

	w0:

r1: 
-\frac{\mathrm{r3}}{2\, \left(\mathrm{r1} + \mathrm{r3}\right)}
r2: 
- \frac{1}{2}
r3: 
-\frac{\mathrm{r1}}{2\, \left(\mathrm{r1} + \mathrm{r3}\right)}
r4: 
0
ra: 
0
rb: 
0
c1: 
- \frac{1}{2}
c2: 
- \frac{1}{2}

	Q:

r1: 
-\frac{\mathrm{r1}\, \left(\frac{\sqrt{\frac{\mathrm{r1}}{\mathrm{r3}} + 1}\, \left(\frac{\mathrm{c1}}{2\, \mathrm{c2}\, \mathrm{r2}\, \sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}}} - \frac{\mathrm{rb}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}}}{\mathrm{r3}\, \mathrm{ra}} + \frac{\mathrm{c2}\, \mathrm{r2}\, \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)}{2\, \mathrm{c1}\, {\mathrm{r1}}^2\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}}}\right)}{{\left(\sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}} - \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} + 1\right)}^2} - \frac{1}{2\, \mathrm{r3}\, \sqrt{\frac{\mathrm{r1}}{\mathrm{r3}} + 1}\, \left(\sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}} - \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} + 1\right)}\right)\, \left(\sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}} - \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} + 1\right)}{\sqrt{\frac{\mathrm{r1}}{\mathrm{r3}} + 1}}
r2: 
\frac{\mathrm{r2}\, \left(\frac{\mathrm{c2}\, \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)}{2\, \mathrm{c1}\, \mathrm{r1}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}}} + \frac{\mathrm{c1}\, \mathrm{r1}}{2\, \mathrm{c2}\, {\mathrm{r2}}^2\, \sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}}}\right)}{\sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}} - \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} + 1}
r3: 
-\frac{\mathrm{r1}\, \left(\mathrm{r3}\, \mathrm{ra} + \mathrm{r3}\, \mathrm{ra}\, \sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}} + \mathrm{r3}\, \mathrm{ra}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} + \mathrm{r1}\, \mathrm{rb}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} + 2\, \mathrm{r3}\, \mathrm{rb}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}}\right)}{2\, \left(\mathrm{r1} + \mathrm{r3}\right)\, \left(\mathrm{r3}\, \mathrm{ra} + \mathrm{r3}\, \mathrm{ra}\, \sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}} + \mathrm{r3}\, \mathrm{ra}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} - \mathrm{r1}\, \mathrm{rb}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}}\right)}
r4: 
0
ra: 
-\frac{\mathrm{r1}\, \mathrm{rb}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}}}{\mathrm{r3}\, \mathrm{ra}\, \left(\sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}} - \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} + 1\right)}
rb: 
\frac{\mathrm{r1}\, \mathrm{rb}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}}}{\mathrm{r3}\, \mathrm{ra}\, \left(\sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}} - \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} + 1\right)}
c1: 
-\frac{\mathrm{c1}\, \left(\frac{\mathrm{r1}}{2\, \mathrm{c2}\, \mathrm{r2}\, \sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}}} + \frac{\mathrm{c2}\, \mathrm{r2}\, \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)}{2\, {\mathrm{c1}}^2\, \mathrm{r1}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}}}\right)}{\sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}} - \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} + 1}
c2: 
\frac{\mathrm{c2}\, \left(\frac{\mathrm{r2}\, \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)}{2\, \mathrm{c1}\, \mathrm{r1}\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}}} + \frac{\mathrm{c1}\, \mathrm{r1}}{2\, {\mathrm{c2}}^2\, \mathrm{r2}\, \sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}}}\right)}{\sqrt{\frac{\mathrm{c1}\, \mathrm{r1}}{\mathrm{c2}\, \mathrm{r2}}} - \left(\frac{\mathrm{r1}\, \mathrm{rb}}{\mathrm{r3}\, \mathrm{ra}} - 1\right)\, \sqrt{\frac{\mathrm{c2}\, \mathrm{r2}}{\mathrm{c1}\, \mathrm{r1}}} + 1}

%}