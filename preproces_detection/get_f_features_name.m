mean_name = string.empty;
std_name = string.empty;
sum_name = string.empty;
eig_name = string.empty;
values_name = string.empty;
max_name = string.empty;
avg_name = ["f_max_bands_avg"];
for i= 1:16
    mean_name(i) = sprintf("f_corr_mean%d", i);
end
for i= 1:16
    std_name(i) = sprintf("f_corr_std%d", i);
end
for i= 1:16
    sum_name(i) = sprintf("f_corr_sum%d", i);
end
for i= 1:16
    eig_name(i) = sprintf("f_corr_eig%d", i);
end
for i= 1:11*16
    values_name(i) = sprintf("f_band_values%d", i);
end
for i= 1:16
    max_name(i) = sprintf("f_max_bands%d", i);
end
f_features_name = [mean_name, std_name, sum_name, eig_name, values_name, max_name, avg_name];
size(f_features_name)