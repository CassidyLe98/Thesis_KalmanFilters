function yk = AlbersNoiseFcn_NonAdd(xk,vk)
% Author: CLe
% Date: 
% Summary:  Example measurement function for discrete time nonlinear
%           state estimators with non-additive measurement noise.
% Inputs:   xk = states at time k, x[k]
%           vk = measurement noise at time, k v[k]
% Outputs:  yk = y[k], measurements at time k
%
% Measurement is the 3rd state (glucose) with additive noise
% Fcn is NonAdd b/c UKF function will not automatically add noise
% So we add noise in the noise function and 
% Call 'HasAdditiveMeasurementNoise' as false
yk = xk(3)+vk;

end
