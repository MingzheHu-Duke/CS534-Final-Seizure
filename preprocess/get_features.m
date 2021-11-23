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
segment = load(fname);
% data -> 16 * 2xxxxxxxxx
segment.data = [residual_data segment.data];

% TODO: get total number of feature
features = zeros([1,512]);

dlength = size(segment.data, 1);
window_lengths = [80,160,240];
max_window = max(window_lengths);

for windowend=max_window:max_window:dlength
    for window_len = window_lengths
        dataseg = segment.data(windowend-window_len:windowend,:);
        dataseg = butterfiltfilt(dataseg,[1,50],segment.sampling_frequency);
        [mCorrs_T, names_mCorrs_T, matirx_sum_T, names_sum_T] = CorrelationTemp(dataseg);
        % assign feature values to features.
        % features = 
    end
end
residual_data = segment.data(:,windowend:end);

    
    


% return features as a struct / vector