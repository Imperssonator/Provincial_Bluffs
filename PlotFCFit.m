function [] = PlotFCFit(StructPath,run)

load(StructPath);
figure
hold on

X = UVS(run).TrimWaves;
En = UVS(run).En;
FCParams = UVS(run).FCFit.Params;
Y1 = FrankConAgg(FCParams,En);
Y2 = FCParams(5)*AmorSpec(StructPath);
Y3 = FrankCondon(FCParams,En,AmorSpec(StructPath));
Y4 = UVS(run).NormAbs;

plot(X,Y1,'--r',X,Y2,'--b',X,Y3,'--g',X,Y4,'-k')

save(StructPath,'UVS')

end