function yk = AlbersMeasFcn(xk)
% Author: Cassidy Le
% Date: November 21, 2019
% Summary:  Measurement function for discrete time nonlinear state
%           estimators. Indicates which states are being "measured".
% Inputs:   xk = states at time k, x[k]
% Outputs:  yk = y[k], measurements at time k

% yk = [xk(1); xk(2); xk(3); xk(4); xk(5); xk(6)];
% Only send out glucose portion xk(3)
yk = xk(3);

end