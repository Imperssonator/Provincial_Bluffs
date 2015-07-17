function [] = NormalizeUV(StructPath,RefName)

%NormalizeUV Normalize UV Spectra Set
%   Normalize the amorphous peak to the Reference spectra spec'd by
%   RefName: string of the name (no file extension) of the spectrum to
%   normalize to

load(StructPath);
RefInd = 0;
for i = 1:length(UVS)
    if strcmp(RefName,UVS(i).Name)
        RefInd = i;                 % RefInd is the element of the structure corresponding to the ref spectrum
        break
    end
end

AbsRef = UVS(RefInd).TrimAbs;
TrimWaves = UVS(RefInd).TrimWaves;

%Find the maximum value of abs

[MaxAbs, MaxInd] =max(AbsRef); % MaxAbs is the maximum absorbace and MaxInd is the index of that absorbance

%Find corresponding value of Waveref

MaxWave=TrimWaves(MaxInd); % MaxWave is the wavelength of the max absorbance

for j = 1:length(UVS)
    Wavesj = UVS(j).TrimWaves;
    NormIndj = find(Wavesj==MaxWave); % This is the index of the jth spectra corresponding to the wavelength to be normalized
    UVS(j).RefSpec = RefInd;
    TrimAbsi = UVS(j).TrimAbs;
    NormAbs=TrimAbsi./TrimAbsi(NormIndj);
    UVS(j).NormAbs = NormAbs;
end

save(StructPath,'UVS')

end

