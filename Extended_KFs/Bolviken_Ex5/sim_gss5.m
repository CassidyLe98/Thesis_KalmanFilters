function [x,z] = sim_gss5(Q,R,m0,P0,N)
% Date: April 3, 2020
% Summary: Simulates measured (Gaussian) data from Bolviken Example 5
%          Example is based on Gordon, Salmond & Smith example

% Code taken from Bolviken Appendix A (page 146-147)
% https://www.mn.uio.no/math/tjenester/kunnskap/kompendier/komp_kalman.pdf

% Inputs: Q = var[w(k)]; 10 in this example
%         R = var[v(k)]; 1 in this example
%         m0 = mean; 0 in this example
%         P0 = standard deviation; 1 in this example
%         N = number of values produced; 50 in this example
%   Note: w(k) is random term in x(k)
%         v(k) is error term in z(k)
% Outputs:  x = simulated data for true state values
%           z = simulated data for measured state values

% Randomly set initial value of state with distribution N(m0,sqrt(P0))
x0 = normrnd(m0, sqrt(P0)); % m0 = mean, P0 = standard deviation
x = zeros(N,1); % Initializing true state vector with zeros
z = zeros(N,1); % Initializing measured state vector with zeros

% Define initial state for x(k) equation with normally distributed noise
% See page 130 of Bolviken paper for information on the system
x(1) = 0.5*x0 + (25*x0/(1 + x0^2)) + 8*cos(1.2*0) + normrnd(0, sqrt(Q));

% Define initial state for z(k) equation with normally distributed noise
% See page 130 of Bolviken paper for information on the system
z(1) = (x(1)^2/20) + normrnd(0, sqrt(R));

% Iterate through each time step to create simulated values for state(s)
for k=2:N
    % Calculate state at time step k for x(k) equation
    % with normally distributed noise
    x(k) = 0.5*x(k-1) + (25*x(k-1)/(1 + x(k-1)^2)) + 8*cos(1.2*(k-1)) + normrnd(0, sqrt(Q));
    
    % Calculate state at time step k for z(k) equation
    % with normally distributed noise
    z(k) = (x(k)^2/20) + normrnd(0, sqrt(R));
end

% Store simulated data in csv file for reproducible results
csvwrite('sim_ex5_true.csv', x); % true state data (x)
csvwrite('sim_ex5__meas.csv',z); % measurement state data (z)

end
