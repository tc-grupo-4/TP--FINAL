function out = sensib(var,f)
    fx0 = diff(f,var);
    out = simplify(fx0/(f/var));
end

