function StructPath = AnalyzeUV(FolderName,RefName)

% Run with this line:
% FN = 'UV Vis 150630'; RefName = '0PRE'; SP = AnalyzeUV(FN,RefName); load(SP);

Directory = BuildDirectory(FolderName);
StructPath = BuildStruct(Directory);
TrimUV(StructPath);
NormalizeUV(StructPath,RefName);
PlotAllUV(StructPath);

InitParams = [50  20  20  20;...
             450 570 620 510;...
             20  10  10  10];
FitGauss(StructPath,InitParams)
GMExcitonBW(StructPath);

FitFC(StructPath);

PlotEB(StructPath);
PlotFCFit(StructPath,20);
PlotGMFit(StructPath,20);

end