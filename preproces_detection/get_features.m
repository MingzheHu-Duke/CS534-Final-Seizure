function features= get_features(fname, fieldid,outfile_name,ictal, plot_flag)

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
% segment = segment.(fieldid);
% data -> 16 * 2xxxxxxxxx

% if segment.sequence == 1
%     residual_data = [];
% end

% segment.data = [residual_data segment.data];
% size(segment.data)
% TODO: get total number of feature
% features = zeros([1,512]);
% 
% dlength = size(segment.data, 2);
% window_lengths = [80,160,240];
% window_lengths = ceil(window_lengths .* segment.sampling_frequency);
% window_lengths = window_lengths + mod(window_lengths,2);
% max_window = max(window_lengths);
% min_window = min(window_lengths);

% for windowend=max_window:min_window:dlength
%     for window_len = window_lengths
% segment.data = segment.data(:,windowend-window_len+1:windowend);
segment.data = butterfiltfilt(segment.data,[1,50],segment.freq);
mCorrs_T = CorrelationTemp(segment.data);
freq_feature_list = get_f_features(segment.data, segment.freq, plot_flag);

% assign feature values to features.
features = [ictal, fieldid, mCorrs_T, freq_feature_list];
writematrix(features,outfile_name,'WriteMode','append');
%     end
% end
% 
% if plot_flag
% end
% residual_data = segment.data(:,windowend:end);
