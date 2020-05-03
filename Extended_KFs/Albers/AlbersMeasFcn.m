function yk = AlbersMeasFcn(xk)
% Author: CLe
% Date: November 21, 2019
% Summary:  Example measurement function for discrete 
%           time nonlinear state estimators
% Inputs:   xk = states at time k, x[k]
% Outputs:  yk = y[k], measurements at time k
%
% The measurement is the first state with multiplicative noise

% yk = [xk(1); xk(2); xk(3); xk(4); xk(5); xk(6)];
% Only send out glucose portion
yk = xk(3);

end