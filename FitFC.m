function [] = FitFC(StructPath)

%FitFC Frank-Condon fit for UV-Vis spectra
%   StructPath is the file path of the UV-Vis structure
%   The function will fit a mixed Frank-Condon function + amorphous peak to
%   yield:
%   Exciton Bandwith (UVS(run).EB) and
%   Percent Aggregates (UVS(run).AggFrac), as well as
%   The Frank-Condon fit structure (UVS(run).FCFit)

load(StructPath)
hc = 1239.842;              % eV*nm

for i = 1:length(UVS)
    
    FCFit = struct();
    Problem = struct();
    
    InitParams = [2.0 ...   Energy of 0-0 peak in eV
                  0 ...  Exciton bandwidth in eV
                  0.04 ... Peak width of FC Peaks
                  0.1 ...   Relative Contribution of FC peaks
                  0.5]; ...   Relative Contribution of Amorphous peak
%                   2.75 ...  Energy of Amorphous peak in eV
%                   0.1 ...   Peak width of Amorphous peak
%                   ];
    
    [LB,UB] = MakeBounds(InitParams);
    OPTIONS = optimoptions('lsqcurvefit');
    Waves = UVS(i).TrimWaves;
    Abs = UVS(i).NormAbs;
    En = hc./Waves;
    UVS(i).En = En;
    ASpec = AmorSpec(StructPath);
    
    Problem.objective = @(Params,En) FrankCondon(Params,En,ASpec);
    Problem.x0 = InitParams;
    Problem.xdata = En;
    Problem.ydata = Abs;
    Problem.lb = LB;
    Problem.ub = UB;
    Problem.solver = 'lsqcurvefit';
    Problem.options = OPTIONS;
    
    [FitParams,RESNORM,RESIDUAL] = lsqcurvefit(Problem);
    
    UVS(i).FCFit.Params = FitParams;
    UVS(i).EB = FitParams(2);
    UVS(i).AggFrac = FitParams(4) / FitParams(5) / 1.39;
    % Aggregate absorbance / Amorphous absorbance, aggregates absorb more strongly per chain
    UVS(i).FCFit.Res = RESIDUAL;
    
end

save(StructPath,'UVS');

end

function [LB, UB] = MakeBounds(InitParams)

[p,k]=size(InitParams);
B = zeros(p,2);

WaveTol = 0.1; % Only allow Gaussians to shift 0.1 eV in either direction from initial guess

B(1,:) = [InitParams(1)-WaveTol, InitParams(1)+WaveTol];
B(2,:) = [-0.2, 0.2];
B(3,:) = [0, Inf];
B(4,:) = [0, Inf];
B(5,:) = [0, Inf];
% B(6,:) = [InitParams(6)-WaveTol, InitParams(6)+WaveTol];
% B(7,:) = [0, 0.3];


LB = B(:,1); UB = B(:,2);

end
    


