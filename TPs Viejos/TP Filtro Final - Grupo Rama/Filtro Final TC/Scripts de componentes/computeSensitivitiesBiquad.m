function [S] = computeSensitivitiesBiquad(expr, values)
    
    if ischar(expr)
        expr = sym(expr);
    end
    
    [N,D] = numden(expr);
    
    N = coeffs(expand(N),sym('s'));
    D = coeffs(expand(D),sym('s'));
    
    if numel(N)==2
        a = N(1);
        b = 0;
        c = N(2);
        d = D(1);
        e = D(2);
        f = D(3);
    elseif numel(N) ==3
        a = N(1);
        b = N(2);
        c = N(3);
        d = D(1);
        e = D(2);
        f = D(3);
    end

    %Compute the expressions
    S(1).name = 'wz';
    S(1).expr = sqrt(c/a);
    S(1).value = evaluate(S(1).expr,values);
    S(1).sensitivities = computeSensitivities(S(1).expr,values);
   
    S(2).name = 'wp';
    S(2).expr = sqrt(f/d);
    S(2).value = evaluate(S(2).expr,values);
    S(2).sensitivities = computeSensitivities(S(2).expr,values);
    
    S(3).name = 'Qz';
    S(3).expr = -1 * sqrt(c/a) * a / b;
    S(3).value = evaluate(S(3).expr,values);
    S(3).sensitivities = computeSensitivities(S(3).expr,values);
    
    S(4).name = 'Qp';
    S(4).expr = sqrt(f/d) * d / e;
    S(4).value = evaluate(S(4).expr,values);
    S(4).sensitivities = computeSensitivities(S(4).expr, values);
    
    
    S(5).name = 'Go';
    S(5).expr = abs(c / f);
    S(5).value = evaluate(S(5).expr,values);
    S(5).sensitivities = computeSensitivities(S(5).expr, values); 
    
    S(6).name = 'Ginf';
    S(6).expr = abs(a / d);
    S(6).value = evaluate(S(6).expr,values);
    S(6).sensitivities = computeSensitivities(S(6).expr, values); 
 
end

    