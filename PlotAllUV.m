function [] = PlotAllUV(StructPath)

load(StructPath)

figure
hold on
for i = 1:length(UVS)
    plot(UVS(i).TrimWaves,UVS(i).NormAbs,'-')
end

end