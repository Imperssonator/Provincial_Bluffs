function StructPath = AnalyzeUV(FolderName,RefName)

Directory = BuildDirectory(FolderName);
StructPath = BuildStruct(Directory);
TrimUV(StructPath)
NormalizeUV(StructPath,RefName)
PlotAllUV(StructPath)

end