function [Waves,Abs] = csv2mat(FilePath)

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
Abs = zeros(LastValInd,1);

WaveCell = Num{1,1};
AbsCell = Num{1,2};

for j = 1:LastValInd
    Wavej = WaveCell{j,1};
    Waves(j,1) = str2num(Wavej(regexp(Wavej,'[-\d\.]')));
    Absj = AbsCell{j,1};
    Abs(j,1) = str2num(Absj(regexp(Absj,'[-\d\.]')));
end

end