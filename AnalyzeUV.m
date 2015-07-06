function StructPath = AnalyzeUV(FolderName,RefName)

Directory = BuildDirectory(FolderName);
StructPath = BuildStruct(Directory);
TrimUV(StructPath);
NormalizeUV(StructPath,RefName);
PlotAllUV(StructPath)

InitGuess = [50  50  50;...
             450 570 620;...
             20  10  10];

FitGauss(StructPath,InitGuess);
ExcitonBW(StructPath);
PlotEB(StructPath);
PlotGMFit(StructPath,2);

end