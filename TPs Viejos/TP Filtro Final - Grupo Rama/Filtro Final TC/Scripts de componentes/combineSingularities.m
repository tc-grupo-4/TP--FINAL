function [ C ] = combineSingularities(singularities)
    warning('off','Control:ltiobject:TFComplex')
    
    % Group conjugate singularities into one tf
    tfs = {};
    s=tf('s');
    for i=1 : numel(singularities)
        n = singularities(i);
        if n.type == 'p'
            p = n.value;
            if p==0
                f=1/s;
            else
                f = 1/(s/p-1);
                
                if imag(p)~=0
                    f = f * 1/(s/conj(p)-1);
                end
            end
        else
            z = n.value;
            if z==0
                f=s;
            else
                f = (s/z-1);
                
                if imag(z)~=0
                    f = f * (s/conj(z)-1);
                end
            end
        end
        
        % Delete imag part (possibly very small because of numeric error)
        num = real(f.num{1});
        num(abs(num)<1e-8) = 0;
        den = real(f.den{1});
        den(abs(den)<1e-8) = 0;
        tfs{end+1} = tf(num,den);
    end
    
    % ALL possible partitions of poles and zeros
    
    P = partitions(tfs)';
    
    % To store only the valid partitions
    Pok = [];
    total = numel(P);
    h = waitbar(0,'Parsing possible partitions...');
    % Then, for each posible partition...
    for i=1 : numel(P)
        waitbar(i/total);
        
        if max(cellfun(@length,P{i}))>2
            continue;
        end
        
        %Check every stage of partition
        ok = true;
        stages = {};
        l=1;
        while l<=numel(P{i}) && ok==true
            
            stageTF = 1;
            
            for k=1 : numel(P{i}{l})
                stageTF = stageTF * P{i}{l}{k};
            end
            
            % Delete trailing zero from num den and obtain # of Zeros and poles
            num = stageTF.num{1};
            den = stageTF.den{1};
            num = num(find(num,1) : end);
            den = den(find(den,1) : end);
            nZ = numel(num)-1;
            nP = numel(den)-1;
            
            % Only 2z and 2p and more p than z
            if nZ>nP % nZ>2 || nP>2 lo chequeo arriba
                ok = false;
            else
                stages{end+1} = stageTF;
            end
            l = l+1;
        end
        
        % If every stage of the partition was ok, store the partition
        if ok == true
            Pok{end+1} = stages;
        end
    end
    close(h)
    C=Pok;
    
end

