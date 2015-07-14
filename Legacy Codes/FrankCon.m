function [] = FrankCon(StructPath,run)

%% OLD - Use FrankCondon instead

%FrankCon Frank Condon aggregate emission spectrum
%   out will be a vector of absorbance values
%   EB is the exciton bandwidth of the deconvoluted spectrum
%   M is the maximum number of peaks to include... up to 6 I guess
%   Waves is the range of wavelengths over which to calculate absorbancies

M = 4; % Hard coded

load(StructPath)

EB = -0.03; %UVS(run).EB;
Params = UVS(run).GMM.Params;
Waves = UVS(run).TrimWaves;

A = zeros(length(Waves),1);
S = 1;                      % Huang Rhys Factor ....
Ep = 0.18;                  % 0.18 eV
hc = 1239.842;              % eV*nm
EVec = hc./Waves;           % This spectrum will be in terms of energy, not wavelength
P00 = Get00Params(Params);  % Get the 0-0 peak parameters
w00 = P00(2);               % Extract the wavelength
E00 = hc/w00;               % Convert to Energy
N = (0:M);

for m = 0:M
    
    Avg = E00+m*Ep;
    Nm = N(N~=m);
    Gm = sum(S.^Nm ./ (factorial(Nm) .* (Nm - m)));
    Params = [1; Avg; 0.055];
    disp(exp(-S)*S^m/factorial(m) * (1 - EB*exp(-S)/(2*Ep) * Gm)^2)
    A = A + exp(-S)*S^m/factorial(m) ...
            * (1 - EB*exp(-S)/(2*Ep) * Gm)^2 ...
            * GaussPeak(Params,1,EVec);
end

UVS(run).Frank = A;
save(StructPath,'UVS')

figure
NormAbs = UVS(run).NormAbs;
plot(EVec,0.35*A,'-b',EVec,NormAbs,'-r')

end
    
