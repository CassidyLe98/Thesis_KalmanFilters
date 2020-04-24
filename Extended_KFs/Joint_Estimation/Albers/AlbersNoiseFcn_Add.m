function yk = AlbersNoiseFcn_Add(xk)
% Author: Cassidy Le
% Date: March 31, 2019
% Summary:  Example measurement function for discrete time nonlinear
%           state estimators with non-additive measurement noise.
% Inputs:   xk = states at time k, x[k]
% Note:     No measurement noise input v[k]
% Outputs:  yk = y[k], measurements at time k
%
% Fcn is Add b/c UKF function will automatically add noise
% So we don't need to add noise in this function
% Just call 'HasAdditiveMeasurementNoise' as true
% Selecting only glucose xk(3) and parameters
yk = [xk(3); xk(7); xk(8); xk(9)];

end
