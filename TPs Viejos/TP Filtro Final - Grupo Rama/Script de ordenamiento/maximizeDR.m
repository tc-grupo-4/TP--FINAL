function [ STAGES ] = maximizeDR( TF, passband )
    
    STAGES = createStages(TF,passband);
    
    STAGES = orderStages(STAGES,passband);
    
    GAIN = evalfr(TF,0);
    STAGES = assignGain(STAGES,GAIN);
    
    for i=1:numel(STAGES)
        bode(STAGES{i});
        hold on;
    end
    
end

