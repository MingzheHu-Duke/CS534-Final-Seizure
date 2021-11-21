function [mCorrs_T, names_mCorrs_T, matirx_sum_T, names_sum_T] = CorrelationTemp(data)

nChans = 16;

%calculate corr
corrs = corr(data);
[V,D] = eig(corrs);
mCorrs_T = []
mCorrs_T(1,:) = mean(corrs);
mCorrs_T(2,:) = std(corrs);
mCorrs_T(3,:) = sum(corrs);
mCorrs_T(4,:) = sum(abs(corrs));
mCorrs_T(5,:) = D

%not sure whether this is required...
names_mCorrs_T = cellstr([repmat('mCorrsT_s', nChans*5,1), ...
    num2str(reshape(repmat((1:5), nChans , 1)', nChans*5, 1)), ...
    repmat('_c', nChans*5,1), ...
    num2str(reshape(repmat((1:nChans), 5, 1), nChans*5,1))])';
names_mCorrs_T = strrep(names_mCorrs_T, ' ', '' );

%calculate summary feature
matirx_sum_T = []
matirx_sum_T(1,:) = reshapemean(data);
matirx_sum_T(2,:) = mean(abs(data));
matirx_sum_T(3,:) = std(data);
matirx_sum_T(4,:) = sum(data);
matirx_sum_T(5,:) = rms(data);
matirx_sum_T(6,:) = kurtosis(data);
matirx_sum_T(7,:) = skewness(data);

%not sure whether this is required...
names_sum_T = cellstr([repmat('mCorrsT_s', nChans*7,1), ...
    num2str(reshape(repmat((1:7), nChans , 1)', nChans*7, 1)), ...
    repmat('_c', nChans*7,1), ...
    num2str(reshape(repmat((1:nChans), 7, 1), nChans*7,1))])';
names_sum_T = strrep(names_sum_T, ' ', '' );