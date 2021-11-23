function [ftype,istest]=get_type(fname)
% e.g. Dog_1_interictal_segment_0001.mat
ix=strfind(fname,'_');  % get the underscore locations
ftype=fname(ix(2)+1:ix(3)-1);
if ftype == "test"
    istest=false;
else
    istest=true;
end
