function [ orderedStages ] = orderStages( stages , passband)
    
    if ~issorted(passband)
        error('Error in passband. Should be a vector with one ([1 100]) or two intervals [1 100 2000 5000] of frequencies')
    elseif numel(passband) == 2
        passband = [passband 0 0];
    elseif numel(passband)~=4
        error('Error in passband. Should be a vector with one ([1 100]) or two intervals [1 100 2000 5000] of frequencies');
    end
    
    permutations = perms(stages);
    freqs = logspace(0,6,10000);
    passband = passband.*2*pi;
    inPassband = find(passband(1)<=freqs & freqs<=passband(2) | passband(3)<=freqs & freqs<=passband(4));
    returnStages = {};
    
    % Fin the combination which minimices: max{ dj=(Mj/mj-1) }
    minimum_djMAX = Inf;
    h = waitbar(0,'Ordering stages...')
    total = length(permutations);
    for i=1 : length(permutations)
        waitbar(i/total);
        
        H = permutations(i,:);
        
        djMAX = 0;
        Hj=1;
        for j=1:numel(H)-1
            Hj=Hj*H{j};
            
            [mag,~,wout] = bode(Hj,logspace(0,6,10000));
            mag = squeeze(mag);
            
            Mj = max(mag);
            mj = min(mag(inPassband));
            dj=Mj/mj-1;
            
            if dj > djMAX
                djMAX = dj;
            end
        end
        
        if djMAX < minimum_djMAX
            minimum_djMAX = djMAX;
            returnStages = permutations(i,:);
        end
    end
    close(h);
    orderedStages = returnStages;
end

