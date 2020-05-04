function yk = vdpMeasurementNonAdditiveNoiseFcn(xk,vk)
% Summary:  Example measurement function for discrete time
%           nonlinear state estimators with non-additive measurement noise.
% Inputs:   xk - x[k], states at time k
%           vk - v[k], measurement noise at time k
% Outputs:  yk - y[k], measurements at time k

% Note: Implementation is from on MATLAB unscentedKalmanFilter example.
%       Copyright 2016 The MathWorks, Inc.
%       https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html

% The measurement is the first state with multiplicative noise
yk = xk(1)*(1+vk);
end