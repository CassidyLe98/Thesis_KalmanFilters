function yk = AlbersMeasFcn(xk)
% Author: Cassidy Le
% Date: November 21, 2019
% Summary:  Measurement function for discrete time nonlinear state
%           estimators. Indicates which states are being "measured".
%           In this case, measuring glucose and all 3 parameters.
% Inputs:   xk = states at time k, x[k]
% Outputs:  yk = y[k], measurements at time k

% yk = [xk(1); xk(2); xk(3); (states: glucose/insulin)
%       xk(4); xk(5); xk(6)]; (states: feeding)
% Selecting only glucose state xk(3)
yk = xk(3);

end
