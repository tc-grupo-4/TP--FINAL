function [ H ] = get_stage_tf(stage_number) 
    switch stage_number
        case 1
            w0 = 2*pi*4999;
            Q = 1.02;
            G = 10^(5.47/20);
            H = tf([G/w0/Q,0], [1/w0^2, 1/w0/Q, 1]);
        case 2
            w0 = 2*pi*2249;
            Q = 1.68;
            G = 10^(0/20);
            H = tf([G/w0^2,0,0], [1/w0^2, 1/w0/Q, 1]);
        case 3
            w0 = 2*pi*11111;
            Q = 1.68;
            G = 10^(6.3/20);
            H = tf([G/w0^2,0,0], [1/w0^2, 1/w0/Q, 1]);
        case 4
            w0 = 2*pi*1626;
            Q = 5.61;
            G = 10^(8.2/20);
            H = tf([G], [1/w0^2, 1/w0/Q, 1]);
        case 5
            w0 = 2*pi*15373;
            Q = 5.6;
            G = 10^(8.25/20);
            H = tf([G], [1/w0^2, 1/w0/Q, 1]);
    end
        


end

