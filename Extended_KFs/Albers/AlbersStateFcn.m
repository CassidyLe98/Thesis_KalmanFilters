function [x] = AlbersStateFcn(x)
% Author: LdP and CLe
% Date: November 19, 2019
% Summary:  Solving x'=f(x) w/ sample time dt

% Updated by LdP March 14, 2020
% Summary: LdP changed integration from Euler to ode45

% Inputs:   x = current states at "time" k-1
% Outputs:  xout(end,:)' = propagated states, x[k+1]

dt = 0.1;

% Convert scale back to total glucose
x(3) = 100.*x(3);

% x is the current state (at "time" k-1)
% Use ODE45 to get x at the next "time" k
initialStateGuess = x; % Current state vector at time k

% Assuming a time-invariant system, the step from k-1
% to k should be independent of t, so we should always
% be a able to go from 0 to 1.
timeVector = 0:dt:1;
[timeSteps,xout] = ode45(@AlbersODE,timeVector,initialStateGuess);

% Convert scale back to glucose per dL
% Convert scale back to total glucose
xout(:,3) = xout(:,3)./100;

x = xout(end,:)'; % Return the final time solution


end