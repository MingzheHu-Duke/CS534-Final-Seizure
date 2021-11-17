clc;clear;close all;

%% random test


signal = data(1,:);

N_clear = 150;

% Remove the calls to fftshift, if you want to delete the lower frequency components
S = fftshift(fft(signal));   
S_cleared = S;
S_cleared(1:N_clear) = 0;
S_cleared(end-N_clear+2:end) = 0;
S_cleared = fftshift(S_cleared);

signal_cleared = ifft(S_cleared);

subplot(2,2,1);
plot(signal);
title('input signal');

subplot(2,2,2);
plot(abs(S));
title('input spectrum');

subplot(2,2,3);
plot(abs(fftshift(S_cleared)));
title('output spectrum');

subplot(2,2,4);
plot(signal_cleared);
title('output signal');
% [b, a] = butter(2,[0.5 47]/(freq/2));


%% test on single data
% fpath = "";
% data = load(fpath);
% % fft choose 0.5~47
% [features,filtered_fft] = get_f_features(data.data);
% data_reconstruct = ?;
% temporal_features = get_t_features(data_reconstruct);


%% loop all files

% change foldre before tun
folder = "../../";

outfile_name = fullfile(folder,"output.csv");
% outfile = open(outfile_name);



tempTable = table();
%loop over subjects
subjects=dir(folder);
for s = 1:length(subjects)
    fprintf("Subject %s\n",subjects(s).name)
    segments=dir(fullfile(folder,subjects(s).name,"*.mat" ));
    residual_data = [];
    %loop over segments/files/10min
    for k = 1:length(segments)
        fprintf("\tSegment %s\n",segments(k).name)
        % skip test files. 
        % hhh
        
        segname=segments(k).name;
        fpath_full = fullfile(folder,subjects(s).name,segname);
        
        [features, residual_data] = get_features(fpath_full,residual_data,plot_flag=0);
        write_features(outfile,features);
    end

end