
close all;
clc;

load ~/Downloads/Dog_1_interictal_segment_0001.mat
%load()
%Y = fft(interictal_segment_1.data,[],2);
[B,A] = butter(5,[1,47]/(400/2));

y_td=filtfilt(B,A,interictal_segment_1.data(1,:));
y_fd= fft(y_td);


Fs = interictal_segment_1.sampling_frequency;
L = size(interictal_segment_1.data,2);
P2 = abs(y_fd/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f_fft = Fs*(0:(L/2))/L;
figure
plot(f_fft,P1) 
title('Fourier analysis')
xlabel('f (Hz)')
ylabel('|P1(f)|')

figure
plot(Fs*(1:L)/L,abs(y_fd))




