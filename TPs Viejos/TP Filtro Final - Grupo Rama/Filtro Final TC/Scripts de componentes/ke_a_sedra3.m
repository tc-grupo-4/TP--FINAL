function [opt_com_wo,opt_com_wz,opt_com_Q] = ke_a_sedra3(wo,wz,ganan,Q,GBW,Q0_min,Q0_init,Q0_max,gb_min,gb_init,gb_max,C_min,C_init,C_max)

syms ga1 ga2 gb c21 c22 g41 g42 c3 g1 C Q0;

%variables a optimizar Q0,gb,C
%parametros que no quiero que varien: ganan, wz, wo y Q
digits(8);


eq_c21 = c21 == -C*(2*Q*Q0^4*ganan*wo^4-2*Q*Q0^4*wo^2*wz^2+4*Q*Q0^3*ganan*wo^3*(GBW*2*pi)-4*Q*Q0^3*wo*(GBW*2*pi)*wz^2+2*Q*Q0^2*ganan*wo^2*(GBW*2*pi)^2-Q*Q0^2*wo^2*wz^2-2*Q*Q0^2*(GBW*2*pi)^2*wz^2+Q0^3*wo^2*wz^2-2*Q*Q0*wo*(GBW*2*pi)*wz^2+Q*ganan*(GBW*2*pi)^2*wz^2+2*Q0^2*wo*(GBW*2*pi)*wz^2-Q*(GBW*2*pi)^2*wz^2+Q0*(GBW*2*pi)^2*wz^2)/((Q0^2*wo^2+2*Q0*wo*(GBW*2*pi)+(GBW*2*pi)^2)*wz^2*(2*Q*Q0^2+Q-Q0));
eq_c22 = c22 == C*Q*ganan*(2*Q0^4*wo^4+4*Q0^3*wo^3*(GBW*2*pi)+2*Q0^2*wo^2*(GBW*2*pi)^2+(GBW*2*pi)^2*wz^2)/((Q0^2*wo^2+2*Q0*wo*(GBW*2*pi)+(GBW*2*pi)^2)*wz^2*(2*Q*Q0^2+Q-Q0));
eq_c3 = c3 == C;
eq_g1 = g1 == (2*C*wo*wo*Q0/GBW)+2*C*wo*Q0;
eq_g41 = g41 == (1/2)*wo*C*(2*Q*Q0^4*wo^2+4*Q*Q0^3*wo*(GBW*2*pi)-2*Q*Q0^2*ganan*(GBW*2*pi)^2+Q*Q0^2*wo^2+2*Q*Q0^2*(GBW*2*pi)^2-Q0^3*wo^2+2*Q*Q0*wo*(GBW*2*pi)-Q*ganan*(GBW*2*pi)^2-2*Q0^2*wo*(GBW*2*pi)+Q*(GBW*2*pi)^2-Q0*(GBW*2*pi)^2)/((2*Q*Q0^2+Q-Q0)*(Q0*wo+(GBW*2*pi))*Q0*(GBW*2*pi));
eq_g42 =  g42 == (1/2)*(2*Q0^2+1)*wo*Q*(GBW*2*pi)*ganan*C/((2*Q*Q0^2+Q-Q0)*(Q0*wo+(GBW*2*pi))*Q0);
eq_ga1 = ga1 == (1/2)*gb*(Q*Q0^2*wo^2-Q0^3*wo^2+2*Q*Q0*wo*(GBW*2*pi)-Q*ganan*(GBW*2*pi)^2-2*Q0^2*wo*(GBW*2*pi)+Q*(GBW*2*pi)^2-Q0*(GBW*2*pi)^2)/(Q*Q0^2*(Q0^2*wo^2+2*Q0*wo*(GBW*2*pi)+(GBW*2*pi)^2));
eq_ga2 = ga2 == (1/2)*gb*ganan*(GBW*2*pi)^2/(Q0^2*(Q0^2*wo^2+2*Q0*wo*(GBW*2*pi)+(GBW*2*pi)^2));

%-------------------------------%%-------------------------------%%-------------------------------%%-------------------------------%

%utilizo funcion magica 'fminsearchbnd' para optimizar la sensibilidad (en
%un rango acotado) de las sensibilidades de Q,ganan,wo,wz


options = optimset('MaxIter', 750); %determino la cantidad maxima de iteraciones que va a realizar cada fminsearch

%-------------------------------%
%empiezo por wo

wo_1 = 0;

wo_1 = wo_1+0.5*(1/g1)*0.005; 
wo_2 = subs(wo_1,g1,solve(eq_g1,g1));
wo_2 =vpa(wo_2);

wo_3 = wo_2 + 0.5*(1/(c21+c22))*0.005;
wo_4 = subs(wo_3,c21,solve(eq_c21,c21));
wo_4 =vpa(wo_4);

wo_5= wo_4+0.5*(1/c3)*0.005;
wo_6 = subs(wo_5,c3,solve(eq_c3,c3));
wo_6 = vpa(wo_6);

wo_7 = wo_6 + 0.5*(1/(g41+g42))*0.005;
wo_8 = subs(wo_7,g41,solve(eq_g41,g41));
wo_8 = vpa(wo_8);

wo_9 = subs(wo_8,g42,solve(eq_g42,g42));
wo_9 = vpa(wo_9);

wo_10 = subs(wo_9,c22,solve(eq_c22,c22));
wo_10 =vpa(wo_10);

wo_optimo = symfun(abs(wo_10),[Q0, gb, C]);

disp('optimizando con respecto a wo...');

if Q0_max<Q

[wo_min, wo_opt] = fminsearchbnd(@(x,varargin) wo_optimo(x(1), x(2), x(3)),[Q0_init gb_init C_init],[Q0_min gb_min C_min],[Q0_max gb_max C_max],options);

else
    [wo_min, wo_opt] = fminsearchbnd(@(x,varargin) wo_optimo(x(1), x(2), x(3)),[Q0_init gb_init C_init],[Q0_min gb_min C_min],[Q gb_max C_max],options);
end
%-------------------------------%
%sigo por wz
wz_1= 0; %saque wz

wz_2 = wz_1 + 0.5*(1/c3)*0.005;
wz_3 = subs(wz_2,c3,solve(eq_c3,c3));
wz_3=vpa(wz_3);

wz_4 = wz_3 + 0.5*(1/c22)*0.005;
wz_4 = vpa(wz_4);


wz_5 = wz_4 + 0.5*(1/g1)*0.005;
wz_6 = subs(wz_5,g1,expand(solve(eq_g1,g1)));
wz_6 = vpa(wz_6);

wz_7  = wz_6 + 0.5*(1/g42)*0.005;           %cambie aca
wz_8 = subs(wz_7, g42, solve(eq_g42,g42));
wz_8 = vpa(wz_8);

wz_9 = subs(wz_8,c22,solve(eq_c22,c22));
wz_9 =vpa(wz_9);
                                        %las otras no las considero porque
                                        %son muy chicas

                                        

wz_optimo = symfun(abs(wz_9),[Q0,gb,C]);

disp('optimizando con respecto a wz...');

if Q0_max<Q

[wz_min, wz_opt] = fminsearchbnd(@(x,varargin) wz_optimo(x(1),x(2),x(3)),[Q0_init,gb_init,C_init],[Q0_min,gb_min,C_min],[Q0_max,gb_max,C_max],options);

else
    [wz_min, wz_opt] = fminsearchbnd(@(x,varargin) wz_optimo(x(1),x(2),x(3)),[Q0_init,gb_init,C_init],[Q0_min,gb_min,C_min],[Q,gb_max,C_max],options);
end

%-------------------------------%
%ahora viene Q

q_1 = 0;

q_1 = q_1 + (Q/Q0-1/2)*(1/g1)*0.01; %cambie
q_2 = subs(q_1, g1, expand(solve(eq_g1,g1)));
q_2 = vpa(q_2);

q_3 = q_2 - 0.5*((Q/Q0-1))*(1/c3)*0.005;%cambie
q_4 = subs(q_3, c3, solve(eq_c3,c3));
q_4 = vpa(q_4);

q_5 = q_4 - ((1/2)*(Q/Q0-1/2))*(1/(g41+g42))*0.01; %cambie
q_6 = subs(q_5, g41, solve(eq_g41,g41));
q_6 = vpa(q_6);

q_7 = subs(q_6, g42, solve(eq_g42,g42));
q_7 = vpa(q_7);


q_8 = q_7 + ((1/2)*(Q/Q0-1/2))*(1/(ga1+ga2))*0.005;
q_9 = subs(q_8, ga1, solve(eq_ga1,ga1));
q_9 = vpa(q_9);
q_10 = subs(q_9, ga2, solve(eq_ga2,ga2));
q_10 = vpa(q_10);
q_11 = q_10 + 0.5*((Q/Q0-1))*(1/c22+c21)*0.005;
q_12 = subs(q_11, c21, solve(eq_c21,c21));
q_12 = vpa(q_12);

q_13 = q_12 - ((1/2)*(Q/Q0-1))*(1/gb)*0.005;

q_14 = subs(q_13,c22,solve(eq_c22,c22));
q_14 =vpa(q_14);


q_optimo = symfun(abs(q_14),[Q0,gb,C])

disp('optimizando con respecto a Q...');

if Q0_max<Q

[q_min, q_opt] = fminsearchbnd(@(x,varargin) q_optimo(x(1),x(2),x(3)),[Q0_init,gb_init,C_init],[Q0_min,gb_min,C_min],[Q0_max,gb_max,C_max],options);

else
    [q_min, q_opt] = fminsearchbnd(@(x,varargin) q_optimo(x(1),x(2),x(3)),[Q0_init,gb_init,C_init],[Q0_min,gb_min,C_min],[Q,gb_max,C_max],options);
end
    



%-------------------------------%%-------------------------------%%-------------------------------%%-------------------------------%
%-------------------------------%
%componentes_wo_opt

%c21
c21_aux = eq_c21;
c21_wo_1 = subs(c21_aux, C, wo_min(3));
c21_wo_1 = vpa(c21_wo_1);
c21_wo_2 = subs(c21_wo_1, Q0, wo_min(1));
c21_wo_2 = vpa(c21_wo_2);
c21_wo_2 = c21 == solve(c21_wo_2,c21);

%c22
c22_aux = eq_c22;
c22_wo_1 = subs(c22_aux, C, wo_min(3));
c22_wo_1 = vpa(c22_wo_1);
c22_wo_2 = subs(c22_wo_1, Q0, wo_min(1));
c22_wo_2 = vpa(c22_wo_2);
c22_wo_2 = c22 == solve(c22_wo_2,c22);

%c3
c3_aux = eq_c3;
c3_wo_1 = subs(c3_aux, C, wo_min(3));
c3_wo_1 = vpa(c3_wo_1);
c3_wo_2 = subs(c3_wo_1, Q0, wo_min(1));
c3_wo_2 = vpa(c3_wo_2);
c3_wo_2 = c3 == solve(c3_wo_2,c3);


%g1
g1_aux = eq_g1;
g1_wo_1 = subs(g1_aux, C, wo_min(3));
g1_wo_1 = vpa(g1_wo_1);
g1_wo_2 = subs(g1_wo_1, Q0, wo_min(1));
g1_wo_2 = vpa(g1_wo_2);
g1_wo_2 = g1 == solve(g1_wo_2,g1);

%g42
g42_aux = eq_g42;
g42_wo_1 = subs(g42_aux, C, wo_min(3));
g42_wo_1 = vpa(g42_wo_1);
g42_wo_2 = subs(g42_wo_1, Q0, wo_min(1));
g42_wo_2 = vpa(g42_wo_2);
g42_wo_3 = subs(g42_wo_2, gb, wo_min(2));
g42_wo_3 = vpa(g42_wo_3);
g42_wo_3 = g42 == solve(g42_wo_3,g42);


%g41
g41_aux = eq_g41;
g41_wo_1 = subs(g41_aux, C, wo_min(3));
g41_wo_1 = vpa(g41_wo_1);
g41_wo_2 = subs(g41_wo_1, Q0, wo_min(1));
g41_wo_2 = vpa(g41_wo_2);
g41_wo_3 = subs(g41_wo_2, gb, wo_min(2));
g41_wo_3 = vpa(g41_wo_3);
g41_wo_3 = g41 == solve(g41_wo_3,g41);

%ga1
ga1_aux = eq_ga1;
ga1_wo_1 = subs(ga1_aux, C, wo_min(3));
ga1_wo_1 = vpa(ga1_wo_1);
ga1_wo_2 = subs(ga1_wo_1, Q0, wo_min(1));
ga1_wo_2 = vpa(ga1_wo_2);
ga1_wo_3 = subs(ga1_wo_2, gb, wo_min(2));
ga1_wo_3 = vpa(ga1_wo_3);
ga1_wo_3 = ga1 == solve(ga1_wo_3,ga1);

%ga2
ga2_aux = eq_ga2;
ga2_wo_1 = subs(ga2_aux, C, wo_min(3));
ga2_wo_1 = vpa(ga2_wo_1);
ga2_wo_2 = subs(ga2_wo_1, Q0, wo_min(1));
ga2_wo_2 = vpa(ga2_wo_2);
ga2_wo_3 = subs(ga2_wo_2, gb, wo_min(2));
ga2_wo_3 = vpa(ga2_wo_3);
ga2_wo_3 = ga2 == solve(ga2_wo_3,ga2);

Q0
opt_com_wo = [c21_wo_2, c22_wo_2, c3_wo_2 ,gb == vpa(wo_min(2)), g1_wo_2 , g41_wo_3 , g42_wo_3 , ga1_wo_3 , ga2_wo_3,  vpa(wo_opt)];

%-------------------------------%
%componentes_wz_opt

%c21
c21_aux = eq_c21;
c21_wz_1 = subs(c21_aux, C, wz_min(3));
c21_wz_1 = vpa(c21_wz_1);
c21_wz_2 = subs(c21_wz_1, Q0, wz_min(1));
c21_wz_2 = vpa(c21_wz_2);
c21_wz_2 = c21 == solve(c21_wz_2,c21);

%c22
c22_aux = eq_c22;
c22_wz_1 = subs(c22_aux, C, wz_min(3));
c22_wz_1 = vpa(c22_wz_1);
c22_wz_2 = subs(c22_wz_1, Q0, wz_min(1));
c22_wz_2 = vpa(c22_wz_2);
c22_wz_2 = c22 == solve(c22_wz_2,c22);

%c3
c3_aux = eq_c3;
c3_wz_1 = subs(c3_aux, C, wz_min(3));
c3_wz_1 = vpa(c3_wz_1);
c3_wz_2 = subs(c3_wz_1, Q0, wz_min(1));
c3_wz_2 = vpa(c3_wz_2);
c3_wz_2 = c3 == solve(c3_wz_2,c3);


%g1
g1_aux = eq_g1;
g1_wz_1 = subs(g1_aux, C, wz_min(3));
g1_wz_1 = vpa(g1_wz_1);
g1_wz_2 = subs(g1_wz_1, Q0, wz_min(1));
g1_wz_2 = vpa(g1_wz_2);
g1_wz_2 = g1 == solve(g1_wz_2,g1);

%g42
g42_aux = eq_g42;
g42_wz_1 = subs(g42_aux, C, wz_min(3));
g42_wz_1 = vpa(g42_wz_1);
g42_wz_2 = subs(g42_wz_1, Q0, wz_min(1));
g42_wz_2 = vpa(g42_wz_2);
g42_wz_3 = subs(g42_wz_2, gb, wz_min(2));
g42_wz_3 = vpa(g42_wz_3);
g42_wz_3 = g42 == solve(g42_wz_3,g42);


%g41
g41_aux = eq_g41;
g41_wz_1 = subs(g41_aux, C, wz_min(3));
g41_wz_1 = vpa(g41_wz_1);
g41_wz_2 = subs(g41_wz_1, Q0, wz_min(1));
g41_wz_2 = vpa(g41_wz_2);
g41_wz_3 = subs(g41_wz_2, gb, wz_min(2));
g41_wz_3 = vpa(g41_wz_3);
g41_wz_3 = g41 == solve(g41_wz_3,g41);

%ga1
ga1_aux = eq_ga1;
ga1_wz_1 = subs(ga1_aux, C, wz_min(3));
ga1_wz_1 = vpa(ga1_wz_1);
ga1_wz_2 = subs(ga1_wz_1, Q0, wz_min(1));
ga1_wz_2 = vpa(ga1_wz_2);
ga1_wz_3 = subs(ga1_wz_2, gb, wz_min(2));
ga1_wz_3 = vpa(ga1_wz_3);
ga1_wz_3 = ga1 == solve(ga1_wz_3,ga1);

%ga2
ga2_aux = eq_ga2;
ga2_wz_1 = subs(ga2_aux, C, wz_min(3));
ga2_wz_1 = vpa(ga2_wz_1);
ga2_wz_2 = subs(ga2_wz_1, Q0, wz_min(1));
ga2_wz_2 = vpa(ga2_wz_2);
ga2_wz_3 = subs(ga2_wz_2, gb, wz_min(2));
ga2_wz_3 = vpa(ga2_wz_3);
ga2_wz_3 = ga2 == solve(ga2_wz_3,ga2);

Q0
opt_com_wz = [c21_wz_2, c22_wz_2 , c3_wz_2 , gb == vpa(wz_min(2)) , g1_wz_2 , g41_wz_3 , g42_wz_3 , ga1_wz_3 , ga2_wz_3,  vpa(wz_opt)];


%-------------------------------%
%componentes_wz_opt

%c21
c21_aux = eq_c21;
c21_q_1 = subs(c21_aux,  C , q_min(3));
c21_q_1 = vpa(c21_q_1);
c21_q_2 = subs(c21_q_1, Q0, q_min(1));
c21_q_2 = vpa(c21_q_2);
c21_q_2 = c21 == solve(c21_q_2,c21);

%c22
c22_aux = eq_c22;
c22_q_1 = subs(c22_aux, C, q_min(3));
c22_q_1 = vpa(c22_q_1);
c22_q_2 = subs(c22_q_1, Q0, q_min(1));
c22_q_2 = vpa(c22_q_2);
c22_q_2 = c22 == solve(c22_q_2,c22);

%c3
c3_aux = eq_c3;
c3_q_1 = subs(c3_aux, C, q_min(3));
c3_q_1 = vpa(c3_q_1);
c3_q_2 = subs(c3_q_1, Q0, q_min(1));
c3_q_2 = vpa(c3_q_2);
c3_q_2 = c3 == solve(c3_q_2,c3);

%g1
g1_aux = eq_g1;
g1_q_1 = subs(g1_aux, C, q_min(3));
g1_q_1 = vpa(g1_q_1);
g1_q_2 = subs(g1_q_1, Q0, q_min(1));
g1_q_2 = vpa(g1_q_2);
g1_q_2 = g1 == solve(g1_q_2,g1);

%g42
g42_aux = eq_g42;
g42_q_1 = subs(g42_aux, C, q_min(3));
g42_q_1 = vpa(g42_q_1);
g42_q_2 = subs(g42_q_1, Q0, q_min(1));
g42_q_2 = vpa(g42_q_2);
g42_q_3 = subs(g42_q_2, gb, q_min(2));
g42_q_3 = vpa(g42_q_3);
g42_q_3 = g42 == solve(g42_q_3,g42);


%g41
g41_aux = eq_g41;
g41_q_1 = subs(g41_aux, C, q_min(3));
g41_q_1 = vpa(g41_q_1);
g41_q_2 = subs(g41_q_1, Q0, q_min(1));
g41_q_2 = vpa(g41_q_2);
g41_q_3 = subs(g41_q_2, gb, q_min(2));
g41_q_3 = vpa(g41_q_3);
g41_q_3 = g41 == solve(g41_q_3,g41);

%ga1
ga1_aux = eq_ga1;
ga1_q_1 = subs(ga1_aux, C, q_min(3));
ga1_q_1 = vpa(ga1_q_1);
ga1_q_2 = subs(ga1_q_1, Q0, q_min(1));
ga1_q_2 = vpa(ga1_q_2);
ga1_q_3 = subs(ga1_q_2, gb, q_min(2));
ga1_q_3 = vpa(ga1_q_3);
ga1_q_3 = ga1 == solve(ga1_q_3,ga1);

%ga2
ga2_aux = eq_ga2;
ga2_q_1 = subs(ga2_aux, C, q_min(3));
ga2_q_1 = vpa(ga2_q_1);
ga2_q_2 = subs(ga2_q_1, Q0, q_min(1));
ga2_q_2 = vpa(ga2_q_2);
ga2_q_3 = subs(ga2_q_2, gb, q_min(2));
ga2_q_3 = vpa(ga2_q_3);
ga2_q_3 = ga2 == solve(ga2_q_3,ga2);

Q0
opt_com_Q = [c21_q_2, c22_q_2 , c3_q_2 , gb == vpa(q_min(2)) , g1_q_2 , g41_q_3 , g42_q_3 , ga1_q_3 , ga2_q_3,  vpa(q_opt)];


end

