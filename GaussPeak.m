function out = GaussPeak(Params,k,W)

out = 0;

for i = 1:k
    area = Params((i-1)*3+1);  % area of this underlying peak
    avg = Params((i-1)*3+2);  % peak wavelength
    sig = Params((i-1)*3+3);  % width of gaussian
    Gi = area * 1/(sig*(2*pi)^0.5) .* exp(-(W-avg).^2./(2*sig^2));
    out = out+Gi;
end

end