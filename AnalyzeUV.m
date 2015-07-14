function StructPath = AnalyzeUV(FolderName,RefName)

Directory = BuildDirectory(FolderName);
StructPath = BuildStruct(Directory);
TrimUV(StructPath);
NormalizeUV(StructPath,RefName);
PlotAllUV(StructPath);
FitFC(StructPath);
% ExcitonBW(StructPath);
PlotEB(StructPath);
PlotFCFit(StructPath,20);

end