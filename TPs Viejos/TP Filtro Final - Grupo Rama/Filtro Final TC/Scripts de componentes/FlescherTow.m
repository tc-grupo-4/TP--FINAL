function [C, S] = FlescherTow(f)
    % Compute the component values for a flescher Tow cell
    % given a biquar transfer function
    
    % The transfer function is
    tf_str = '-1*((R8/R6)*s^2 + 1/(R1*C1)*(R8/R6-(R1*R8)/(R4*R7))*s+R8/(R3*R5*R7*C1*C2))/(s^2+1/(R1*C1)*s+R8/(R2*R3*C1*C2*R7))';
   
    num = f.num{1,1};
    den = f.den{1,1};
    
    num = num./den(1);
    den = den./den(1);
    
    m = num(1);
    c = num(2);
    d = num(3);
    a = den(2);
    b = den(3);
        
    % Free parameters
    k1 = 1;
    k2 = 1;
    C1 = 10e-9;
    C2 = 10e-9;
    R8 = 10e3;
    
    % Compute the other components
    C.R1 = 1/(a*C1);
    C.R2 = k1/(sqrt(b)*C2);
    C.R3 = 1/(k1*k2)*1/(sqrt(b)*C1);
    C.R4 = 1/(k2*C1*(m*a-c));
    C.R5 = k1*sqrt(b)/(d*C2);
    C.R6 = R8/m;
    C.R7 = k2*R8;
    C.R8 = R8;
    C.C1 = C1;
    C.C2 = C2;
       
    
    S = computeSensitivitiesBiquad(tf_str, C);
     
     
    %f1 = tf([-k2*(m*a-c) -k2*(m*b-d)],[1 a b]);
    %f3 = tf([-1/k1*(d-m*b)/sqrt(b) -1/k2*(a*d-b*c)/sqrt(b)],[1 a b]);
    bode(f);
    
    
end
