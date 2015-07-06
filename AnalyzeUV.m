function StructPath = AnalyzeUV(FolderName,RefName)

Directory = BuildDirectory(FolderName);
StructPath = BuildStruct(Directory);
TrimUV(StructPath);
NormalizeUV(StructPath,RefName);
%PlotAllUV(StructPath)

InitGuess = [50  50  50;...
             450 570 620;...
             20  10  10];

FitGauss(StructPath,InitGuess);

PlotGMFit(StructPath,13)

end