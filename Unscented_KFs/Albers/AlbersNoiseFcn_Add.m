function yk = AlbersNoiseFcn_Add(xk)
% Author: Cassidy Le
% Date: November 19, 2019
% Summary:  Measurement function for discrete time nonlinear
%           state estimators with additive measurement noise.
%           Indicates which states the UKF algorithm is estimating.
%           In this case, only one state (glucose).
%           Fcn is additive b/c UKF function will automatically add noise
%           so we don't need to add noise in this function.
%           Just call 'HasAdditiveMeasurementNoise' as true.
% Inputs:   xk = states at time k, x[k]
% Outputs:  yk = y[k], measurements at time k

% Note:     No measurement noise input v[k] b/c algorithm will be set
%           to include noise additively by calling
%           'HasAdditiveMeasurementNoise' as true.

% yk = [xk(1); xk(2); xk(3); (states: glucose/insulin)
%       xk(4); xk(5); xk(6)]; (states: feeding)
% Selecting only glucose state xk(3)
yk = xk(3);

end
