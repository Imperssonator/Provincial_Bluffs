function GMM = GMFit(X,Y,InitParams)
%% Gaussian Mixture Fit
% This function takes data vectors X and Y and fits a mixture of 1-D
% Gaussians to the data given an initial guess InitParams

% Init Params is [3 x k], where k is the number of peaks to fit, and the 3
% parameters are:
% [Mixing proportion; peak center (wavelength); peak width]

% GMM is a structure with the outputs of the nonlinear fit

GMM = struct();
[p,k] = size(InitParams);

InitParamVec = InitParams(:);

GMFun = @(Params,W) GaussPeak(Params,k,W);

[Params,R,J,COVB,MSE] = nlinfit(X,Y,GMFun,InitParamVec);

FitAbs = GaussPeak(Params,k,X);
Params = reshape(Params,3,k);

GMM.Params = Params;
GMM.R = R;
GMM.MSE = MSE;
GMM.FitAbs = FitAbs;

end

