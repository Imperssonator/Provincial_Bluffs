function [] = PlotGMFit(StructPath,run)

load(StructPath);
figure
hold on

X = UVS(run).TrimWaves;
Y1 = UVS(run).NormAbs;
Y2 = UVS(run).GMM.FitAbs;

plot(X,Y1,'-k',X,Y2,'-r')

Params = UVS(run).GMM.Params; % Pull out the Gaussian parameters
[p,~] = size(Params);
k = floor(p/3);

GMParams = reshape(Params(1:end-1),3,k);

for i = 1:k
    Yi = GaussPeak(GMParams(:,i),1,X);
    plot(X,Yi,'--b')
end

plot(X,Params(end).*UVS(UVS(1).RefSpec).NormAbs,'--c')

save(StructPath,'UVS')

end