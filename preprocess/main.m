clc;clear;close all;

%% test on single data
fpath = "";
data = load(fpath);
% fft choose 0.5~47
[features,filtered_fft] = get_f_features(data.data);
data_reconstruct = ?;
temporal_features = get_t_features(data_reconstruct);


%% loop all files

% older = "../../";
% icd = readtable(folder+"icd.csv") ;
% fpath = folder + "deidentified_trc/";
% 
% outfile = folder+"output.csv";
% 
% T = table(); 
% tempTable = table();
% %loop over files
% for line=1:size(icd,1)
%     fprintf("%i\n",icd.id(line))
%     files=dir(fpath+icd.id(line)+'/*.trc');
%     for k = 1:length(files)
%         fname=files(k).name;
%         fpath_sub = icd.id(line)+"/"+fname;
%         outcome = tremor_analysis(...
%             'fname', fpath+fpath_sub,...
%             'markername', 'L.Finger3.M3', 'plot_flag', 0);
%         
%         tempTable.record_id = icd.id(line); 
%         tempTable.file = fpath_sub; 
%         tempTable.icd = icd.icd(line); 
%         tempTable.markername = {'L.Finger3.M3'}; 
%         tempTable.max_p = outcome(1);
%         tempTable.f_max_p = outcome(2);
%         tempTable.f_sd = outcome(3);
%         tempTable.rms_power = outcome(4);
%         T = [T;tempTable];
%     end
% end
% %write to file.
% writetable(T,outfile)