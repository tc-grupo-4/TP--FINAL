function [  ] = groupdelay_analog(file)
data=csvread(file);
w = 2*pi()*data(:,1);
phase = data(:,4);
%w = w(1:60);
%phase = phase(1:60);

dw = diff(w);
dphase = diff(phase);

gd = -dphase./dw;
f = w(1:85)/2/pi();
gd = gd(1:85);
semilogx(f, gd, 'o-', 'LineWidth', 2);
hold on;

y1 = gd(1)*0.95;
y2 = 0;
x1 = 1000;
x2 = 2200;

x = [x1, x2, x2];
y = [y1, y1, y2];
plot(x, y, 'LineWidth',3);
formataxes('', 'Frecuencia (Hz)', 'Retardo de grupo (s)');