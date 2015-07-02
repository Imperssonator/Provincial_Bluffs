function StructPath = BuildStruct(Directory)

UVS = struct();

NumFiles = length(Directory);

count = 0;
for i = 1:NumFiles
    FilePath = Directory{i,1};
    [Waves,RawAbs] = csv2mat(FilePath);
    if Waves == 0
    else
        count = count+1;
        UVS(count).Waves = Waves;
        UVS(count).RawAbs = RawAbs;
        UVS(count).FilePath = FilePath;
        SlashInd = regexp(FilePath,'[\\/]');
        LastSlash = SlashInd(end);
        SpecName = FilePath(LastSlash+1:end-4);
        UVS(count).Name = SpecName;
        Folder = FilePath(1:LastSlash);
    end
end

StructPath = [Folder 'UVStruct'];
save(StructPath,'UVS')

end