function x = vdpStateFcn(x) 
% Summary:  Example state transition function for discrete-time nonlinear
%           state estimators. Discrete-time approximation to van der Pol
%           ODEs for mu = 1. Sample time is 0.05s.
% Inputs:   xk - States x[k]
% Outputs:  xk1 - Propagated states x[k+1]

% Note: Implementation is from on MATLAB unscentedKalmanFilter example.
%       Copyright 2016 The MathWorks, Inc.
%       https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html

% Euler integration of continuous-time dynamics x'=f(x) with sample time dt
dt = 0.05; % [s] Sample time
x = x + vdpStateFcnContinuous(x)*dt;
end

function dxdt = vdpStateFcnContinuous(x)
% Summary: Evaluate the van der Pol ODEs for mu = 1
dxdt = [x(2); % velocity
       (1-x(1)^2)*x(2)-x(1)]; % acceleration
end