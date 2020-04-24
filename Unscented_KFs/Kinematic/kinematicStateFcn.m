function [x] = kinematicStateFcn(x)
% Author: Cassidy Le
% Date: November 5, 2019
% Summary:  Euler integration of continuous-time
%           dynamics x'=f(x) w/ sample time dt

% Initial values
% x = [0; 2];

% Inputs:   xk = states, x[k]
% Outputs:  xk1 = propagated states, x[k+1]

dt = 0.05;
t = 0; % dummy time variable for Kinematic1
% x = x + kinematicStateFcnContinuous(x)*dt;
x = x + Kinematic1(t,x)*dt;
end

%{
function dxdt = kinematicStateFcnContinuous(x)
% Evaluate the kinematic ODE

g = -9.81; % Gravity m/s^2
dxdt = [x(2); -9.81];
end
%}