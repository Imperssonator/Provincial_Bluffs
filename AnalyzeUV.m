function StructPath = AnalyzeUV(FolderName,RefName)

Directory = BuildDirectory(FolderName);
StructPath = BuildStruct(Directory);
TrimUV(StructPath);
NormalizeUV(StructPath,RefName);
PlotAllUV(StructPath)

InitGuess = [50  20  20  20;...
             450 570 620 510;...
             20  10  10  10];

FitGauss(StructPath,InitGuess);
ExcitonBW(StructPath);
PlotEB(StructPath);
PlotGMFit(StructPath,20);

end