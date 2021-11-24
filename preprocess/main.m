clc;clear;close all;

%% random test


% signal = data(1,:);
% 
% N_clear = 150;
% 
% % Remove the calls to fftshift, if you want to delete the lower frequency components
% S = fftshift(fft(signal));   
% S_cleared = S;
% S_cleared(1:N_clear) = 0;
% S_cleared(end-N_clear+2:end) = 0;
% S_cleared = fftshift(S_cleared);
% 
% signal_cleared = ifft(S_cleared);
% 
% subplot(2,2,1);
% plot(signal);
% title('input signal');
% 
% subplot(2,2,2);
% plot(abs(S));
% title('input spectrum');
% 
% subplot(2,2,3);
% plot(abs(fftshift(S_cleared)));
% title('output spectrum');
% 
% subplot(2,2,4);
% plot(signal_cleared);
% title('output signal');
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
folder = "~/Downloads/seizure_pred/";

% outfile_name = get_filename(folder,output,".csv");

% writematrix(feature_names,outfile_name)

%loop over subjects
% outfile_name = get_filename(folder,subjects(s).name,".csv");
segments=dir(fullfile(folder,"*","*.mat" ));
residual_data = [];
%loop over segments/files/10min
for k = 1:length(segments)
    try
        fprintf("\nSegment %s",segments(k).name)
        segname=segments(k).name;
        segfolder = segments(k).folder;
        % skip test files. 
        [ftype, istest, subj_name, fieldname] = get_type(segname);

        outfile_name = get_filename(folder,subj_name,".csv");

        if istest
            fprintf("test")
            continue
        end

        fpath_full = fullfile(segfolder,segname);
        class_preictal = 1*(ftype == "preictal");

        [features, residual_data] = get_features(fpath_full,fieldname,...
            residual_data,outfile_name,class_preictal,false);
    catch
        fprintf("\tERROR!!")
    end
    
end
fprintf('\n');
