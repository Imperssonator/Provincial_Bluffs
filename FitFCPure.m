function [EB,FitParams] = FitFCPure(Waves,Abs)

%FitFC Frank-Condon fit for UV-Vis spectra
%   StructPath is the file path of the UV-Vis structure
%   The function will fit a mixed Frank-Condon function + amorphous peak to
%   yield:
%   Exciton Bandwith (UVS(run).EB) and
%   Percent Aggregates (UVS(run).AggFrac), as well as
%   The Frank-Condon fit structure (UVS(run).FCFit)

hc = 1239.842;              % eV*nm
Weights = MakeWeights(Waves);


Problem = struct();

InitParams = [2.0 ...   Energy of 0-0 peak in eV
              20 ...  Exciton bandwidth in eV
              0.04 ... Peak width of FC Peaks
              0.1]; ...   Relative Contribution of FC peaks

[LB,UB] = MakeBounds(InitParams);
OPTIONS = optimoptions('lsqcurvefit');
En = hc./Waves;
M = 3; % Number of peaks to include in the aggregate FC portion

Problem.objective = @(Params,En) Weights.*FrankConAgg(Params,En,M);
Problem.x0 = InitParams;
Problem.xdata = En;
Problem.ydata = Weights.*Abs;
Problem.lb = LB;
Problem.ub = UB;
Problem.solver = 'lsqcurvefit';
Problem.options = OPTIONS;

[FitParams,RESNORM,RESIDUAL] = lsqcurvefit(Problem);

EB = FitParams(2);

figure
hold on

FitAbs = FrankConAgg(FitParams,En,M);
plot(Waves,Abs,'-k',Waves,FitAbs,'--b')

end

function [LB, UB] = MakeBounds(InitParams)

B = [];

WaveTol = 0.1; % Only allow Gaussians to shift 0.1 eV in either direction from initial guess

B(1,:) = [InitParams(1)-WaveTol, InitParams(1)+WaveTol];
B(2,:) = [-0.2, 0.2];
B(3,:) = [0, Inf];
B(4,:) = [0, Inf];

LB = B(:,1); UB = B(:,2);

end

function Weights = MakeWeights(Waves)

% Only fit FC from 475 nm to 650 nm

Lower = Waves>550;
Upper = Waves<630;
Weights = Lower&Upper;

end



