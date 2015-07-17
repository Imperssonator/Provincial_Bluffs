function GMM = GMFit(X,Y,InitParams,AmorAbs)
%% Gaussian Mixture Fit
% This function takes data vectors X and Y and fits a mixture of 1-D
% Gaussians to the data given an initial guess InitParams

% Init Params is [3 x k], where k is the number of peaks to fit, and the 3
% parameters are:
% [Mixing proportion; peak center (wavelength); peak width]

% GMM is a structure with the outputs of the nonlinear fit

GMM = struct();
Problem = struct();
[p,~] = size(InitParams);
k = floor(p/3);

[LB,UB] = MakeBounds(InitParams,k);
OPTIONS = optimoptions('lsqcurvefit');

Problem.objective = @(Params,Waves) Gauss_Amor(Params,k,Waves,AmorAbs);
Problem.x0 = InitParams;
Problem.xdata = X;
Problem.ydata = Y;
Problem.lb = LB;
Problem.ub = UB;
Problem.solver = 'lsqcurvefit';
Problem.options = OPTIONS;

[FitParams,RESNORM,RESIDUAL] = lsqcurvefit(Problem);

FitAbs = Gauss_Amor(FitParams,k,X,AmorAbs);

GMM.Params = FitParams;
GMM.Res = RESIDUAL;
GMM.SSE = sum(RESIDUAL.^2);
GMM.FitAbs = FitAbs;

end

function [LB, UB] = MakeBounds(InitParams,k)

LB = zeros(3*k+1,1); UB = zeros(3*k+1,1);

WaveTol = 15; % Only allow Gaussians to shift 15 nm in either direction from initial guess

for i = 1:k
    LB(3*(i-1)+1) = 0;    UB(3*(i-1)+1) = Inf;  % Peak area bounds
    LB(3*(i-1)+2) = InitParams(3*(i-1)+2)-WaveTol;    % Wavelength bounds: - and + WaveTol
    UB(3*(i-1)+2) = InitParams(3*(i-1)+2)+WaveTol;
    LB(3*(i-1)+3) = 0;    UB(3*(i-1)+3) = Inf;
end

LB(end) = 0; UB(end) = Inf;

end
    

