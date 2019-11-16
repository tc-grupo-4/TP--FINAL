function [ H ] = get_sk_stage(r1, r2, c1, c2) 
    w0 = 1/sqrt(r1*r2*c1*c2);
    q = sqrt(r1*r2*c1/c2)/(r1+r2);
    
    H = tf(1, [1/w0^2, 1/w0/q, 1]);
end

