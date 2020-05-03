function yk = AlbersNoiseFcn_Add(xk)
% Author: CLe
% Date: November 19, 2019
% Summary:  Example measurement function for discrete time nonlinear
%           state estimators with non-additive measurement noise.
% Inputs:   xk = states at time k, x[k]
% Note:     No measurement noise input v[k]
% Outputs:  yk = y[k], measurements at time k
%
% Measurement is the 3rd state (glucose)
% Fcn is Add b/c UKF function will automatically add noise
% So we don't need to add noise in this function
% Just call 'HasAdditiveMeasurementNoise' as true
yk = xk(3);

end
