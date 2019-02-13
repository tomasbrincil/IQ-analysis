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


%% 1 - Fourierova transformace
figure(1);
subplot(2,1,1);
plot(tt,y);
title('IQ obálka signálu');
ylabel("normalizovaná amplituda [-]");
xlabel("èas [s]");

n = length(y);
X = fft(y);
Y = fftshift(X);
fshift = (-n/2:n/2-1)*(fs*s/n);
powershift = abs(Y).^2/n;

a = length(fshift);
b = a/2;
fshift_half = fshift(b+1:a);
powershift_half = powershift(b+1:a);

subplot(2,1,2);
plot(fshift_half,powershift_half);
title('FFT - Fourierova transformace - výkonová hustota spektra');
ylabel("energie [-]");
xlabel("frekvence [Hz]");
hu = fs/2;
%axis([0 hu 0 0]);


%% 2 - Hilbertova transformace
figure(2);
subplot(2,1,1);
plot(tt,y);
title('IQ obálka signálu');
ylabel("normalizovaná amplituda [-]");
xlabel("èas [s]");
subplot(2,1,2);
yh=hilbert(y);
plot(tt,yh);
title('Hilbertova transformace');
ylabel("normalizovaná amplituda [-]");
xlabel("èas [s]");

%% 3 - Durbinova metoda


%% 4 - Burgova metoda
figure(4);
subplot(2,1,1);
plot(powershift_half);
title('FFT - Fourierova transformace - výkonová hustota spektra');
ylabel("energie [-]");
xlabel("frekvence [Hz]");
subplot(2,1,2);
ypb=pburg(powershift_half,16);
plot(ypb);
title('Burgova metoda - autoregrese modelu spektra');
ylabel("energie [-]");
xlabel("frekvence [Hz]");

%% 5 - Pronyho metoda

%% 6 - Metoda MUSIC
figure(5);
subplot(2,1,1);
plot(tt,y);
title('IQ obálka signálu');
ylabel("normalizovaná amplituda [-]");
xlabel("èas [s]");
subplot(2,1,2);
pmusic(y,64);
title('Metoda MUSIC - výkonová hustota spektra');
ylabel("energie [-]");
xlabel("frekvence [Hz]");
%% 7 - Metoda ESPRIT

%% 8 - Metoda typu waterfall
figure(7);
subplot(2,1,1);
plot(tt,y);
title('IQ obálka signálu');
ylabel("normalizovaná amplituda [-]");
xlabel("èas [s]");
subplot(2,1,2);
spectrogram(y,2,1,100,fs,'yaxis');
title('Spektrogram');
xlabel("poèet vzorkù [-]");
ylabel("frekvence [Hz]");