function [x] = kinematicStateFcn(x)
% Author: Cassidy Le
% Date: November 5, 2019
% Summary:  Euler integration of continuous-time
%           dynamics x'=f(x) w/ sample time dt
% Dependencies: Kinematic1.m

% Inputs:   xk = states, x[k]
% Outputs:  xk1 = propagated states, x[k+1]

dt = 0.05; % Size of time step

t = 0; % dummy time variable for Kinematic1 to run in line 16

% Euler integration of kinematics equation
x = x + Kinematic1(t,x)*dt;
end
