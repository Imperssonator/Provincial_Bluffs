function out = FrankCondon(Params,En,ASpec)

% InitParams = ...
%    1: [2.0 ...   Energy of 0-0 peak in eV
%    2: 0.02 ...  Exciton bandwidth in eV
%    3: 0.055 ... Peak width of FC Peaks
%    4: 1.0 ...   Relative Contribution of FC peaks
%    5: 1.0 ...   Relative Contrib. of Amorphous peak
%    6: 2.75 ...  Energy of Amorphous peak in eV
%    7: 0.1 ...   Peak width of Amorphous peak
%       ];

out = zeros(length(En),1);

E00 = Params(1);            % Convert to Energy
EB = Params(2);
FCwid = Params(3);
FCWeight = Params(4);
AmorWeight = Params(5);
% AmorParams = [1; Params(6); Params(7)];

S = 1;                      % Huang Rhys Factor ....
Ep = 0.18;                  % 0.18 eV C=C symmetric stretch
M = 5;                      % whatever, 4, 6, 12, who cares after 3 really
N = (0:M);

FCPeaks = zeros(length(En),1);

for m = 0:M
    
    Avg = E00+m*Ep;
    Nm = N(N~=m);
    Gm = sum(S.^Nm ./ (factorial(Nm) .* (Nm - m)));
    FCParams = [1; Avg; FCwid];
%     disp(exp(-S)*S^m/factorial(m) * (1 - EB*exp(-S)/(2*Ep) * Gm)^2)
    FCPeaks = FCPeaks + exp(-S)*S^m/factorial(m) ...
              * (1 - EB*exp(-S)/(2*Ep) * Gm)^2 ...
              * GaussPeak(FCParams,1,En);
end

out = (FCWeight * FCPeaks) + (AmorWeight * ASpec); % GaussPeak(AmorParams,1,En));

end
