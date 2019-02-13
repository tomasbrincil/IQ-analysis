clear all
close all
s = 1;
%fs = 19200;
[y, fs] = audioread('./src/F1B.WAV');
n = length(y);
dt = 1 / fs;
tt = 0:dt:n*dt-dt;


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
plot(fshift_half,powershift_half);
title('FFT - Fourierova transformace - výkonová hustota spektra');
ylabel("energie [-]");
xlabel("frekvence [Hz]");
subplot(2,1,2);
ypb=pburg(y,16);
plot(ypb);
title('Burgova metoda - autoregrese modelu spektra');
ylabel("energie [-]");
xticks([10 20 30 40 50 60 70 80 90 100 110 120 130 140]);
xticklabels([0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000]);
xlabel("frekvence [Hz]");

%% 5 - Pronyho metoda

%% 6 - Metoda MUSIC
figure(6);
subplot(2,1,1);
plot(tt,y);
title('IQ obálka signálu');
ylabel("normalizovaná amplituda [-]");
xlabel("èas [s]");
subplot(2,1,2);
pmusic(y,64);
title('Metoda MUSIC - výkonová hustota spektra');
ylabel("energie [-]");
xticks([0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]);
xticklabels([0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000]);
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
st=0:0.001:2;
sx=chirp(st,100,1,200,'quadratic');
spectrogram(y,64,63,512,fs,'yaxis');
%spectrogram(y,1,1,1000,fs,'yaxis');
title('Spektrogram');
xlabel("èas [s]");
ylabel("frekvence [kHz]");