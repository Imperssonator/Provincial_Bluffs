function StructPath = AnalyzeUV(FolderName,RefName)

% Run with this line:
% FN = 'UV Vis 150630'; RefName = '0PRE'; SP = AnalyzeUV(FN,RefName); load(SP);

Directory = BuildDirectory(FolderName);
StructPath = BuildStruct(Directory);
TrimUV(StructPath);
NormalizeUV(StructPath,RefName);
PlotAllUV(StructPath);

InitParams = [20;  ...  Gaussian Areas
              510; ...  Gaussian Averages
              10;  ...  Gaussian Width
              
              20;  ...  0-1 Peak
              570;
              10;
              
              20;  ...  0-0 Peak
              620;
              10;
              
              1];  ...  Amorhpous Contrib.
FitGauss(StructPath,InitParams)
GMExcitonBW(StructPath);

FitFC(StructPath);
FitFCAgg(StructPath);

PlotEB(StructPath);
PlotFCFit(StructPath,20);
PlotGMFit(StructPath,20);

end