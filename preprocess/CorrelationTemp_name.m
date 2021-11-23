function mCorrs_T_name = CorrelationTemp_name()

nChans = 16;
mCorrs_T_name = []


for i = 1:nChans    
    mCorrs_T_name=[mCorrs_T_name,'T_corrs_mean'+i];
end


for i = 1:nChans    
    mCorrs_T_name=[mCorrs_T_name,"T_corrs_std"+i];
end

for i = 1:nChans   
    mCorrs_T_name=[mCorrs_T_name,"T_corrs_sum"+i];
end

for i = 1:nChans    
    mCorrs_T_name=[mCorrs_T_name,"T_corrs_abs_sum"+i];
end

for i = 1:nChans    
    mCorrs_T_name=[mCorrs_T_name,"T_corrs_D"+i];
end

for i = 1:nChans    
    mCorrs_T_name=[mCorrs_T_name,"T_mean"+i];
end

for i = 1:nChans    
    mCorrs_T_name=[mCorrs_T_name,"T_abs_mean"+i];
end

for i = 1:nChans    
    mCorrs_T_name=[mCorrs_T_name,"T_std"+i];
end

for i = 1:nChans   
    mCorrs_T_name=[mCorrs_T_name,"T_sum"+i];
end

for i = 1:nChans   
    mCorrs_T_name=[mCorrs_T_name,"T_rms"+i];
end

for i = 1:nChans    
    mCorrs_T_name=[mCorrs_T_name,"T_kurtosis"+i];
end

for i = 1:nChans   
    mCorrs_T_name=[mCorrs_T_name,"T_skewness"+i];
end


