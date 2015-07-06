function [] = FitGauss(StructPath,InitParams)

load(StructPath);

for i = 1:length(UVS)
    X = UVS(i).TrimWaves;
    Y = UVS(i).NormAbs;
    GMMi = GMFit(X,Y,InitParams);
    UVS(i).GMM = GMMi;
end

save(StructPath,'UVS')

end

