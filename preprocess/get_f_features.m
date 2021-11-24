function freq_feature_list = get_f_features(segment, dataseg, plot_flag)
    % Prepare the data and the sampling frequency
    fs = segment.sampling_frequency;
    data = dataseg;
    nChans = size(segment.channels, 2);
    %% Compute the correlation features
    % 
    
    % Butterworth filter
    y_td = data;
    % Store the frequency domain data
    filtered_fft = zeros(size(y_td));
    % Store the single side amplitude spectrum
    P1_data = zeros(nChans, size(data,2)/2+1, 'single');
    % Length of original data
    L = size(dataseg,2);
    
    parfor c=1:size(filtered_fft, 1)
        % Fourier transform
        filtered_fft(c, :) =  fft(y_td(c, :))
        y_fd = filtered_fft(c, :);
    
        % Double side
        P2 = abs(y_fd/L);
        % Single side
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
    
        f_fft = fs*(0:(L/2))/L;
        if plot_flag
            figure
            plot(f_fft,P1) 
            title('Single-Sided Amplitude Spectrum of X(t)')
            subtitle(sprintf('%dth Channel', c))
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
        end
        P1_data(c, :) = P1
    end    
    %%
    % Compute the corraltion matrix
    corrs = corr(P1_data');
    % Visualize the matrix
    if plot_flag
        figure
        imagesc(corrs)
        xlabel("nth Channel")
        ylabel("nth Channel")
        title("Correlation Matrix")
    end
    %%
    % Compute the eigen values of correlation matrix
    corr_eig = eig(corrs);
    %%
    % Assign field values to feature structure
    feature = struct();
    feature.corr_mat = corrs;
    feature.corr_mean = mean(corrs);
    feature.corr_std = std(corrs);
    feature.corr_sum = sum(corrs);
    feature.corr_eig = corr_eig;
    %% Compute the Band Power Features
    
    % Define the bands Limits
    bLims = [[1;3], [4;7], [8;9], [10;12], [13;17], [18;30],...
        [31;40], [41;50], [51;70], [71;150], [151;250]]; 
    % Number of Bands
    nBands = size(bLims,2);
    % Store the bands values
    bands_value = zeros(nBands, 16, 'single');
    % Store the Max band value Per Channel
    max_bands =  zeros(1, 16, 'single');
    
    
    for c=1:size(filtered_fft, 1)
        % Fourier transform
        filtered_fft(c, :) =  fft(y_td(c, :));
        y_fd = filtered_fft(c, :);
    
        % Double side
        P2 = abs(y_fd/L);
        % Single side
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
    
        f_fft = fs*(0:(L/2))/L;
    
        for b = 1:nBands
            bIdx = f_fft>=bLims(1,b) & f_fft<=bLims(2,b);
            
            mPower = mean(P1(bIdx));
            
            bands_value(b, c) = mPower;
    
        end
    
        max_bands(1,c) = max(bands_value(:,c));
    
    end  
    %%
    % Max_band average
    max_bandavg = mean(max_bands);
    % Add field values
    feature.bands_value = bands_value;
    feature.max_bands = max_bands;
    feature.max_bands_avg = max_bandavg;
    %%
    freq_feature_list = [feature.corr_mean, feature.corr_std,...
        feature.corr_sum, (feature.corr_eig)', reshape(feature.bands_value, 1, []), feature.max_bands, feature.max_bands_avg];
    size(freq_feature_list);
end    
