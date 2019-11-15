clear;
H1=get_stage_tf(1);
H2=get_stage_tf(2);
H2=H2*H1;
H3=get_stage_tf(3);
H3=H2*H3;
H4=get_stage_tf(4);
H4=H4*H3;
H5=get_stage_tf(5);
H5=H5*H4;

bode(H1);
hold on;
grid on;


bode(H2);
bode(H3);
bode(H4);
bode(H5);
hold off;