function yk = AlbersNoiseFcn_Add(xk)
% Author: Cassidy Le
% Date: March 31, 2019
% Summary:  Measurement function for discrete time nonlinear
%           state estimators with additive measurement noise.
%           Indicates which states the EKF algorithm is estimating.
%           In this case, only one state (glucose) and all 3 parameters.
%           Fcn is additive b/c EKF function will automatically add noise
%           so we don't need to add noise in this function.
%           Just call 'HasAdditiveMeasurementNoise' as true.
% Inputs:   xk = states at time k, x[k]
% Outputs:  yk = y[k], measurements at time k

% Note:     No measurement noise input v[k] b/c algorithm will be set
%           to include noise additively by calling
%           'HasAdditiveMeasurementNoise' as true.

% yk = [xk(1); xk(2); xk(3); (states: glucose/insulin)
%       xk(4); xk(5); xk(6); (feeding)
%       xk(7); xk(8); xk(9)]; (parameters)
% Selecting only glucose xk(3) and parameters
yk = [xk(3); xk(7); xk(8); xk(9)];

end
