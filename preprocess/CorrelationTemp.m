function mCorrs_T = CorrelationTemp(data)

nChans = 16;

%calculate corr
corrs = corr(data);
[V,D] = eig(corrs);
mCorrs_T = []
mCorrs_T(1,:) = mean(corrs);
mCorrs_T(2,:) = std(corrs);
mCorrs_T(3,:) = sum(corrs);
mCorrs_T(4,:) = sum(abs(corrs));
mCorrs_T(5,:) = D;


%calculate summary feature
mCorrs_T(6,:) = mean(data);
mCorrs_T(7,:) = mean(abs(data));
mCorrs_T(8,:) = std(data);
mCorrs_T(9,:) = sum(data);
mCorrs_T(10,:) = rms(data);
mCorrs_T(11,:) = kurtosis(data);
mCorrs_T(12,:) = skewness(data);


mCorrs_T = reshape(mCorrs_T,[1,192])