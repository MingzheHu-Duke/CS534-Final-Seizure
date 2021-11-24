function [ftype,istest,subj_name,fieldid]=get_type(fname)
% e.g. Dog_1_interictal_segment_0001.mat
ix=strfind(fname,'_');  % get the underscore locations
ftype=fname(ix(2)+1:ix(3)-1);
istest= ftype == "test";
subj_name = fname(1:ix(2)-1);
fieldid = str2num(fname(ix(end)+1:end-4));
