function [features,filtered_fft]=get_f_features(data,fs)
% fs -> sampling frequency
% data -> 16*length
filtered_fft = fft(data);
features = 0;