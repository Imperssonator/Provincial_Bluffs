function Directory = BuildDirectory(FolderName)

%% Build Directory
% Takes the name of a folder full of UV-Vis .csv files and a .xlsx directory
% and converts it to

% Directory: a cell array (Nx1) of strings that are the file paths of UV
% Vis csv files

%Input computer specfic pathway to the correct file
if ispc
    DirectoryPath= ['C:\Users\Mike\Documents\GitHub\Provincial_Bluffs\' FolderName '\'];
else
    DirectoryPath = ['/Users/Imperssonator/Documents/MATLAB/Provincial_Bluffs/' FolderName '/'];
end

cd(FolderName)

D = dir('*.csv');

cd ..

Files = {D(:).name}';

NumFiles = length(Files);
Directory = {};

for i = 1:NumFiles
    Directory{i,1} = [DirectoryPath Files{i,1}];
end

end

% %Convert Raw Data files into Matlab arrays
% for i=1:length(Directory)
%    [Waves,RawAbs] = csv2mat(Directory(i)) 
% end
% 
% %Determine normalization parameters based on the top entry in Directory
% [MaxWave, Abs]=NormalizeUVVisRef(Directory(1))
% 
% %Normalize remaining UV-Vis Curves
% for i=2:length(Directory)
%     [Abs]=NormalizeUVVis(DirectoryPath, MaxWave)
% end
% 
