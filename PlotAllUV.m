function out = PlotAllUV(StructPath)

load(StructPath)

figure
hold on
for i = 1:length(UVS)
    plot(UVS(i).TrimWaves,UVS(i).NormAbs,'-')
    legend(UVS(i).Name)
end

end