function [ STAGES ] = createStages( TF , passband)
    
    % Check passband
    if ~issorted(passband)
        error('Error in passband. Should be a vector with one ([1 100]) or two intervals [1 100 2000 5000] of frequencies')
    elseif numel(passband) == 2
        passband = [passband 0 0];
    elseif numel(passband)~=4
        error('Error in passband. Should be a vector with one ([1 100]) or two intervals [1 100 2000 5000] of frequencies');
    end
    
    freqs = logspace(0,6,1000);
    passband = passband.*2*pi;
    inPassband = find(passband(1)<=freqs & freqs<=passband(2) | passband(3)<=freqs & freqs<=passband(4));
    
    
    % Quedarse solo con las singularidades del segundo cuadrante
    [POLES,ZEROS] = pzmap(TF);
    POLES(imag(POLES)<0) = [];
    ZEROS(imag(ZEROS)<0) = [];
    
    P = struct('value',[],'type',[]);
    
    for i=1:numel(POLES)
        P(i).value = POLES(i);
        P(i).type = 'p';
    end
    
    for i=numel(POLES)+1: numel(POLES)+numel(ZEROS);
        P(i).value = ZEROS(i-numel(POLES));
        P(i).type = 'z';
    end
    
    % Get all possible combination of zeros and poles
    FILTERS = combineSingularities(P);
    
    % Fin the combination which minimices: max{ dj=(Mj/mj-1) }
    minimum_djMAX = Inf;
    h = waitbar(0,'Maximizing dymamic range...');
    total = numel(FILTERS);
    returnFilter = {};
    for i=1 : numel(FILTERS)
        waitbar(i/total);
        filter = FILTERS{i};
        
        djMAX = 0;
        
        for j=1:numel(filter)
            [mag,~,~] = bode(filter{j},logspace(0,6,1000));
            mag = squeeze(mag);
            
            Mj = max(mag);
            mj = min(mag(inPassband));
            dj = Mj/mj-1;
            
            if dj > djMAX
                djMAX = dj;
            end
        end
        
        if djMAX < minimum_djMAX
            minimum_djMAX = djMAX;
            returnFilter = FILTERS{i};
        end
    end
    close(h);
    STAGES=returnFilter;
    
end

