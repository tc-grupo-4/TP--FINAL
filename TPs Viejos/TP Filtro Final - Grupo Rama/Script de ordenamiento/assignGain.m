function [ FINAL_STAGES ] = assignGain( STAGES, GAIN )
    
    M = zeros(1,numel(STAGES));
    tj = 1;
    for j=1:numel(STAGES)
        tj = tj*STAGES{j};
        [mag,~,~] = bode(tj,logspace(0,6,1000));
        mag = squeeze(mag);
        M(j) = max(mag);
    end
    
    FINAL_STAGES{1}=STAGES{1}*GAIN*M(end)/M(1);
    
    for i=2:numel(STAGES)
        FINAL_STAGES{i}=STAGES{i}*M(i-1)/M(i);
    end
    
    
    
