function yk = AlbersMeasFcn(xk)
% Author: CLe
% Date: March 31, 2020
% Summary:  Example measurement function for discrete 
%           time nonlinear state estimators
% Inputs:   xk = states at time k, x[k]
% Outputs:  yk = y[k], measurements at time k
%
% The measurement is the first state with multiplicative noise

% yk = [xk(1); xk(2); xk(3); (states: glucose/insulin)
%       xk(4); xk(5); xk(6); (feeding)
%       xk(7); xk(8); xk(9)]; (parameters)
% Selecting only glucose xk(3) and parameters
yk = [xk(3); xk(7); xk(8); xk(9)];

end