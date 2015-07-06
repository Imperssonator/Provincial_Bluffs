function [] = PlotEB(StructPath)

load(StructPath)
figure
hold on

for i = 4:length(UVS)
    plot(i,UVS(i).EB,'ob')
end
end
