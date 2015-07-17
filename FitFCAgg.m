function [] = FitFCAgg(StructPath)

run = 20;
load(StructPath)
Waves = UVS(run).TrimWaves;
Abs = UVS(run).NormAbs;

[EB,FitParams] = FitFCPure(Waves,Abs);

UVS(run).PureEB = EB;
UVS(run).PureParams = FitParams;

save(StructPath,'UVS')

end