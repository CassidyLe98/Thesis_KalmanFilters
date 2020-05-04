function yk = kinematicMeasurementFcn(xk)
% Author: Cassidy Le
% Date: November 6, 2019
% Summary:  Measurement function for discrete time linear state
%           estimators. Indicates which states are being "measured".
%           In this case, measuring velocity.
% Inputs:   xk = states at time k, x[k]
% Outputs:  yk = y[k], measurements at time k

% yk = [xk(1); (state: velocity)
%       xk(2)]; (state: gravity)
% The measurement is velocity xk(1) with multiplicative noise
yk = xk(1);
end