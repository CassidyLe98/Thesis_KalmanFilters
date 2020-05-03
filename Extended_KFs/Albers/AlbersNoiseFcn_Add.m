function yk = AlbersNoiseFcn_Add(xk)
% Author: Cassidy Le
% Date: November 19, 2019
% Summary:  Measurement function for discrete time nonlinear
%           state estimators with additive measurement noise.
%           Indicates which states the EKF algorithm is estimating.
%           Fcn is additive b/c EKF function will automatically add noise
%           so we don't need to add noise in this function.
%           Just call 'HasAdditiveMeasurementNoise' as true.
% Inputs:   xk = states at time k, x[k]
% Outputs:  yk = y[k], measurements at time k

% Note:     No measurement noise input v[k] b/c algorithm will be set
%           to include noise additively by calling
%           'HasAdditiveMeasurementNoise' as true.


% Measurement is the 3rd state (glucose)
yk = xk(3);

end
