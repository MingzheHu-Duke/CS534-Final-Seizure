function data = butterfiltfilt(data_ori,frange,smp_freq)
[B,A] = butter(2,frange/(smp_freq/2));
data = zeros(size(data_ori));
parfor c=1:size(data_ori,1) %1:16
    data(c,:)=filtfilt(B,A,data_ori(c,:));
end
