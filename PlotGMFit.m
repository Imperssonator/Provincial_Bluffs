function [] = PlotGMFit(StructPath,run)

load(StructPath);
figure
hold on

X = UVS(run).TrimWaves;
Y1 = UVS(run).NormAbs;
Y2 = UVS(run).GMM.FitAbs;

plot(X,Y1,'-k',X,Y2,'-r')

save(StructPath,'UVS')

end