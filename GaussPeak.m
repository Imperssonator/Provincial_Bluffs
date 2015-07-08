function out = GaussPeak(Params,k,W)

%GaussPeak Vectorized Gaussian Peak
%   out is a vector of the output of a mixture of Gaussians given the input
%   W, which is a vector of wavelengths.
%   k = number of Gaussian peaks
%   Params = [3 x k]:
%   [Peak area 1 ...  Peak area k;
%    Wavelength 1...  Wavelength k;
%    Peak width 1...  Peak width k]

out = 0;

for i = 1:k
    area = Params((i-1)*3+1);  % area of this underlying peak
    avg = Params((i-1)*3+2);  % peak wavelength
    sig = Params((i-1)*3+3);  % width of gaussian
    Gi = area * 1/(sig*(2*pi)^0.5) .* exp(-(W-avg).^2./(2*sig^2));
    out = out+Gi;
end

end