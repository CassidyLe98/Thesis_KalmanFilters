function dydt = vdp1(t,y)
% Summary:  Evaluate the van der Pol ODEs for mu = 1
%           See also ODE113, ODE23, ODE45.
% Inputs:   y = input vector
% Outputs:  set of DEs

% Note: Implementation is from on MATLAB unscentedKalmanFilter example.
%       Jacek Kierzenka and Lawrence F. Shampine
%       Copyright 1984-2014 The MathWorks, Inc.
%       https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html

% Output DE vector consists of velocity y(2) and acceleration
dydt = [y(2); % velocity
        (1-y(1)^2)*y(2)-y(1)]; % acceleration
end