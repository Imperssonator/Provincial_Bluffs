function [Abs]=NormalizeUVVis(DirectoryPath, MaxWave)

%Need to specify file names format
load(DirectoryPath);

%Let there be an input file that reads the wavelength (Waveref) and absorbance
%(Absref).

%Find corresponding index MaxWave
k=find(Wave==MaxWave)

%Find MaxAbs based on this index
MaxAbs=Abs(k)
%Find corresponding value of Waveref

Abs=Abs./MaxAbs

end