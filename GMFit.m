function GMM = GMFit(X,Y,InitParams)
%% Gaussian Mixture Fit
% This function takes data vectors X and Y and fits a mixture of 1-D
% Gaussians to the data given an initial guess InitParams

% Init Params is [3 x k], where k is the number of peaks to fit, and the 3
% parameters are:
% [Mixing proportion; peak center (wavelength); peak width]

% GMM is a structure with the outputs of the nonlinear fit

GMM = struct();
Problem = struct();
[p,k] = size(InitParams);

InitParamVec = InitParams(:);
[LB,UB] = MakeBounds(InitParams);
OPTIONS = optimoptions('lsqcurvefit');

Problem.objective = @(Params,W) GaussPeak(Params,k,W);
Problem.x0 = InitParamVec;
Problem.xdata = X;
Problem.ydata = Y;
Problem.lb = LB;
Problem.ub = UB;
Problem.solver = 'lsqcurvefit';
Problem.options = OPTIONS;

[Params,RESNORM,RESIDUAL] = lsqcurvefit(Problem);

FitAbs = GaussPeak(Params,k,X);
Params = reshape(Params,3,k);

GMM.Params = Params;
GMM.Res = RESIDUAL;
GMM.SSE = sum(RESIDUAL.^2);
GMM.FitAbs = FitAbs;

end

function [LB, UB] = MakeBounds(InitParams)

[p,k]=size(InitParams);
LB = zeros(p*k,1); UB = zeros(p*k,1);

WaveTol = 15; % Only allow Gaussians to shift 15 nm in either direction from initial guess

for i = 1:k
    LB(3*(i-1)+1) = 0;    UB(3*(i-1)+1) = Inf;  % Peak area bounds
    LB(3*(i-1)+2) = InitParams(2,i)-WaveTol;    % Wavelength bounds: - and + WaveTol
    UB(3*(i-1)+2) = InitParams(2,i)+WaveTol;
    LB(3*(i-1)+3) = 0;    UB(3*(i-1)+3) = Inf;
end

end
    

