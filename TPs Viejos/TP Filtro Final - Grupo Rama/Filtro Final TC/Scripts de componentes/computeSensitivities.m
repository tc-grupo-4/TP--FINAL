function [T] = computeSensitivities(expr, values)
    vars = symvar(char(expr))';

  
    sen=cell( 1,numel(vars));
    senValue=zeros( 1,numel(vars));
    senChar=cell( 1,numel(vars));
    if ischar(expr)
        expr = sym(expr);
    end
     
    for i=1:numel(vars)
        %a=diff(expr,vars{1,i})
        %b=sym(vars{1,i})
        %c=expr
        %d=a*b/c;
        sen{i} = diff(expr,vars{1,i}) * sym(vars{1,i}) / expr;
        senChar{i}=char(sen{i});
       senValue(i) =  evaluate(sen{i},values);
    end 
    
    s = num2cell(1:numel(vars));
    
    for i=1:numel(vars)
        s{i}=num2str(s{i});
    end
    
    T = table(vars',sen',senChar',senValue','VariableNames',{'Variable','Sensitivity','String','Value'},'RowNames',s');
    
end