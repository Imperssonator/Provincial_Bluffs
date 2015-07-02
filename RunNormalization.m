
%Input computer specfic pathway to the correct file
DirectoryPath='C:\Users\Mike\Documents\GitHub\Provincial_Bluffs\UV Vis 150630'

%Read excel file of file names to populate the directory
Directory=GetDirectory(DirectoryPath)

for i=1:length(Directory)
Directory(i)=strcat(DirectoryPath, '\', Directory(i))
end

%Convert Raw Data files into Matlab arrays
for i=1:length(Directory)
   [Waves,RawAbs] = csv2mat(Directory(i)) 
end

%Determine normalization parameters based on the top entry in Directory
[MaxWave, Abs]=NormalizeUVVisRef(Directory(1))

%Normalize remaining UV-Vis Curves
for i=2:length(Directory)
    [Abs]=NormalizeUVVis(DirectoryPath, MaxWave)
end

