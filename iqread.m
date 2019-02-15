clear all
close all

fs = 244444;
file = 'C:/Users/Anonymous/Documents/GitHub/IQ-analysis/src/2FSK KV/13.4199MHz_20161109_122803.binIQ';

fileID = fopen(file, 'r', 'b');
fdir = dir(file);
size = fdir.bytes;
size = 100;

y = [];

for i = 0:size/2
    I = fread(fileID, 1, '*uint16', 'ieee-be');
    Q = fread(fileID, 1, '*uint16', 'ieee-be');
    In = I*I;
    Qn = Q*Q;
    amplitude = In+Qn;
    y = [y amplitude];
end

