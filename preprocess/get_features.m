function [features, residual_data] = get_features(fname, residual_data, plot_flag)

% open file
% slide windows 
% if sequence == 1 
%   reset residual data / empty
% else 
%   pre-append previous residual data
%
% each window :
% 80, 160, 240
% timepoint start from 240, step 80;
% version_temp = filt with butterworth
% freq-domain(version_temp)
%   bandpower 9
%   corr
%   corr-eigen
%   ? 1-47
% temp-domain(version_temp)
%   corr
%   corr-eigen
%   mean, abs(mean), std,rms, kurtosis, skewness
CorrelationTemp(version_temp)
    
    


% return features as a struct / vector