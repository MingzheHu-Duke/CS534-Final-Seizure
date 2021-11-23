function outfile_name = get_filename(folder,fname,extension)
fileindex_ = 0;
outfile_name = fullfile(folder,fname+extension);
while exist(outfile_name, 'file')
    fileindex_ = fileindex_ + 1;
    outfile_name = fullfile(folder,fname+"("+fileindex_+")"+extension);
end