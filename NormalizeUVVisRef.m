function [MaxWave, Abs]=NormalizeUVVisRef(DirectoryPath)

%Need to specify file names format
load(DirectoryPath);

%Let there be an input file that reads the wavelength (Waveref) and absorbance
%(Absref).

%Find the maximum value of abs

MaxAbs=max(Abs)

%Find corresponding index of this max abs
k=find(Abs==MaxAbs)

%Find corresponding value of Waveref

MaxWave=Wave(k)

Abs=Abs./MaxAbs

end

