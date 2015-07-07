function [] = TrimUV(StructPath)

load(StructPath);

for i = 1:length(UVS)
    RawAbsi = UVS(i).RawAbs;
    RawWavesi = UVS(i).Waves;
    TrimLow = find(RawWavesi==375);
    TrimHigh = find(RawWavesi==700);
    
    TrimWavesi = RawWavesi(TrimLow:TrimHigh);
    TrimAbsi = RawAbsi(TrimLow:TrimHigh);
    
    UVS(i).TrimAbs = TrimAbsi;
    UVS(i).TrimWaves = TrimWavesi;
end

save(StructPath,'UVS')

end

