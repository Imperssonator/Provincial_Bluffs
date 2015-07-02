function [Waves,RawAbs] = csv2mat(FilePath)

%% csv2mat
% CSV2MAT takes a filepath (starting from the current matlab active
% directory) to a UV-Vis .csv file, and parses it to obtain:

% Waves: A column vector of wavelengths
% RawAbs: A column vector of the raw absorbance values

%% Open file and read in data as strings

fid = fopen(FilePath);
C = textscan(fid,'%s',3,'Delimiter',',');
Num = textscan(fid,'%s%s%s','Delimiter',',');
fclose(fid);

ColumnSizes = zeros(1,3);
for i = 1:3
    ColumnSizes(i) = size(Num{:,i},1);
end

LastValInd = min(ColumnSizes);

Waves = zeros(LastValInd,1);
RawAbs = zeros(LastValInd,1);

WaveCell = Num{1,1};
AbsCell = Num{1,2};

%% Remove strings

for j = 1:LastValInd
    Wavej = WaveCell{j,1};
    Waves(j,1) = str2num(Wavej(regexp(Wavej,'[-\d\.]')));
    Absj = AbsCell{j,1};
    RawAbs(j,1) = str2num(Absj(regexp(Absj,'[-\d\.]')));
end

end