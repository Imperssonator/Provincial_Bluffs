function out = Gauss_Amor(Params,k,Waves,AmorAbs)

out = GaussPeak(Params(1:end-1),k,Waves)...
    + Params(end).*AmorAbs;

end