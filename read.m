clear all
close all

I = [];
Q = [];
y = [];

s = 1;
%fs = 50000;
fs = 1;
T = 1 / fs;
t = T/s:T/s:T;

file = './src/2FSK KV/13.4199MHz_20161109_122803.binIQ';

fileID = fopen(file, 'r', 'b');
s = dir(file);
%s.bytes
ALL = fread(fileID, 1000, 'uint8');

for i = 1:500
     y1=ALL(i*2-1)*cos(2*pi); % inphase component
     y2=ALL(i*2)*sin(2*pi) ;% Quadrature component
     I=[I y1]; % inphase signal vector%     
     Q=[Q y2]; %quadrature signal vector
     y=[y y1+y2]; % modulated signal vector
end

plot(y);
