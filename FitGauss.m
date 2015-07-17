function [] = FitGauss(StructPath,InitParams)

%FitGauss Non-linear Gaussian mixture peak fitting

%   Inputs are StructPath: the string that says where the UV structure is,
%   and
%   InitParams: a [3 x k] matrix, where k is the number of Gaussian peaks
%   to fit, and the three rows are:
%   [Peak area 1 ...  Peak area k;
%    Wavelength 1...  Wavelength k;
%    Peak width 1...  Peak width k]

load(StructPath);
AmorAbs = AmorSpec(StructPath);

for i = 1:length(UVS)
    X = UVS(i).TrimWaves;
    Y = UVS(i).NormAbs;
    GMMi = GMFit(X,Y,InitParams,AmorAbs);
    UVS(i).GMM = GMMi;
end

save(StructPath,'UVS')

end

