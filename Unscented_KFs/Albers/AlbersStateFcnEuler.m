function [x] = AlbersStateFcn(x)
% Author: LdP and CLe
% Date: November 19, 2019
% Summary:  Euler integration of continuous-time
%           dynamics x'=f(x) w/ sample time dt

% Inputs:   xk = states, x[k]
% Outputs:  xk1 = propagated states, x[k+1]

dt = 0.05;
t = 0;
x = x + AlbersODE(t, x)*dt;

end
