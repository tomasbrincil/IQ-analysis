clear all
close all

I = [];
Q = [];
y = [];

s = 1;
fs = 50000;
%fs = 1;
T = 1 / fs;
t = T/s:T/s:T;

file = './src/2FSK KV/13.4199MHz_20161109_122803.binIQ';

fileID = fopen(file, 'r', 'b');
i = dir(file);
%s.bytes
ALL = fread(fileID, 10000, 'uint8');

for i = 1:500
     y1=(ALL(i*2-1)-128)/128*cos(2*pi); % inphase component
     y2=(ALL(i*2)-128)/128*sin(2*pi) ;% Quadrature component
     I=[I y1]; % inphase signal vector%     
     Q=[Q y2]; %quadrature signal vector
     y=[y y1+y2]; % modulated signal vector
end

tt=T/s:T/s:(T*500);

figure(1);
subplot(3,1,1);
plot(tt,y);
title('IQ obálka signálu');
ylabel("normalizovaná amplituda [-]");
xlabel("èas [s]");


n = length(y);
X = fft(y);
Y = fftshift(X);
fshift = (-n/2:n/2-1)*(fs*s/n);
powershift = abs(Y).^2/n;

subplot(3,1,2);
plot(fshift,powershift);
title('FFT - Fourierova transformace - výkonová hustota spektra');
ylabel("energie [-]");
xlabel("frekvence [Hz]");
hu = fs/2;
%axis([0 hu 0 0]);

yh=hilbert(y);

subplot(3,1,3);
plot(tt,yh);
