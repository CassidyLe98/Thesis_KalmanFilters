function yk = kinematicMeasurementFcn(xk)
% Author: Cassidy Le
% Date: November 6, 2019
% Summary:  Example measurement function for discrete 
%           time nonlinear state estimators
% Inputs:   xk = states at time k, x[k]
% Outputs:  yk = y[k], measurements at time k
%
% The measurement is the first state with multiplicative noise

yk = xk(1);
end