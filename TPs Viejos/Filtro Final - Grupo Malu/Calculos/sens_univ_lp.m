clearvars;
clear;
clc;
syms r1 r2 r3 r4 ra rb c1 c2 s;

%{

H = -(r1*r4*rb)/(r3*(c1*c2*r1*r2*r4*ra*s^2 + c2*r1*r2*ra*s + r4*rb));
entonces H == -r1/r3 * 1/( (c1*c2*r1*r2*ra)/rb*s^2 + c2*r1*r2*ra/(r4*rb)*s + 1)
%}

w0 = sqrt(rb/(c1*c2*r1*r2*ra));
Q = r4*sqrt(c1*rb/(c2*r1*r2*ra));
G = -r1/r3;

vars = [G, w0, Q];
nvars = size(vars,2);
params = [r1, r2, r3, r4, ra, rb, c1, c2];
nparams = size(params,2);

for i=1:nvars
    for j=1:nparams
        sens(i,j) = simplify(params(j)/vars(i) * diff(vars(i), params(j)));
		sens(i,j)
% 		latex(sens(i,j))
% 		sprintf('i = %d, j = %d ',i,j)
	end    
end

%{
		G:
	r1: 
1
1
	r2:
0
0
	r3:
-1
-1
	r4:
0
0
	ra: 
0
0
	rb:
0
0
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
	ra: 
-1/2
- \frac{1}{2}
	rb: 
1/2
\frac{1}{2}
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
-1/2
- \frac{1}{2}
	r3:
0
0
	r4:
1
1
	ra: 
-1/2
- \frac{1}{2}
	rb: 
1/2
\frac{1}{2}
	c1:
1/2
\frac{1}{2}
	c2:
-1/2
- \frac{1}{2}

%}


