function [] = PlotGMFit(StructPath,run)

load(StructPath);
figure
hold on

X = UVS(run).TrimWaves;
Y1 = UVS(run).NormAbs;
Y2 = UVS(run).GMM.FitAbs;

plot(X,Y1,'-k',X,Y2,'-r')

Params = UVS(run).GMM.Params; % Pull out the Gaussian parameters
[p,k] = size(Params);

for i = 1:k
    Yi = GaussPeak(Params(:,i),1,X);
    plot(X,Yi,'--b')
end

save(StructPath,'UVS')

end