function yk = kinematicMeasurementNonAdditiveNoiseFcn(xk,vk)
% Author: Cassidy Le
% Date: November 6, 2019
% Summary:  Example measurement function for discrete time nonlinear
%           state estimators with non-additive measurement noise.
% Inputs:   xk = states at time k, x[k]
%           vk = measurement noise at time, k v[k]
% Outputs:  yk - y[k], measurements at time k
%
% The measurement is the first state with multiplicative noise
yk = xk(1)+vk;
end