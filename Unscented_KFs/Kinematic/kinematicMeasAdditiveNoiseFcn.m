function yk = kinematicMeasurementNonAdditiveNoiseFcn(xk,vk)
% Author: Cassidy Le
% Date: November 6, 2019
% Summary:  Measurement function for discrete time linear state
%           estimators with non-additive measurement noise.
%           Indicates which states the UKF algorithm is estimating.
%           In this case, only one state (velocity).
%           Fcn is additive b/c UKF function will automatically add noise
%           so we don't need to add noise in this function.
%           Just call 'HasAdditiveMeasurementNoise' as true.
% Inputs:   xk = states at time k, x[k]
%           vk = measurement noise at time, k v[k]
% Outputs:  yk - y[k], measurements at time k

% yk = [xk(1); (state: velocity)
%       xk(2)]; (state: gravity)
% The measurement is velocity xk(1)
yk = xk(1);
end