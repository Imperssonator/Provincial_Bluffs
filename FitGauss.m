function [] = FitGauss(StructPath,InitParams)

load(StructPath);

for i = 1:12  %length(UVS)
    X = UVS(i).TrimWaves;
    Y = UVS(i).NormAbs;
    GMMi = GMFit(X,Y,InitParams);
    UVS(i).GMM = GMMi;
end

InitParams = [50  20  20  20;...
              450 570 620 520;...
              20  10  10  10];

for i = 13:length(UVS)
    X = UVS(i).TrimWaves;
    Y = UVS(i).NormAbs;
    GMMi = GMFit(X,Y,InitParams);
    UVS(i).GMM = GMMi;
end

save(StructPath,'UVS')

end

