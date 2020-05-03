function [x,z] = sim_gss7(Q,R,m0,P0,N)
% Author: Cassidy Le
% Date: March 18, 2020
% Summary: Simulates measured (Gaussian) data for states and parameter
%          for Example 7 in Bolviken (page 133) textbook
%          Code is based on Bolviken code (pages 146-147)
%          https://www.mn.uio.no/math/tjenester/kunnskap/kompendier/komp_kalman.pdf

% Inputs: Q = var[w(k)]; 0.1 in this example
%         R = var[v(k)]; 0.2 in this example
%         m0 = mean; [1.85, 0.95] in this example
%         P0 = variance; [1 0; 0 1] in this example
%         N = number of values produced; 50 in this example
%   Note: w(k) is random term in x(k)
%         v(k) is error term in z(k)
% Outputs:  x = simulated data for true state values
%           z = simulated data for measured state values

% Randomly set initial value of states with distribution N(m0,sqrt(P0))
x0 = [normrnd(m0(1), sqrt(P0(1,1))); m0(2)]; % m0 = mean, P0 = standard deviation
x = zeros(N,2); % Initializing true state vector with zeros
z = zeros(N,1); % Initializing measured state vector with zeros

% Defining initial state for x(k) equation with normally distributed noise
% See page 133 of Bolviken paper for information on the system
x(1,1) = x0(1)*x0(2) + normrnd(0, sqrt(Q)); % State x1 (state variable)
x(1,2) = x0(2); % State x2 (parameter)

% Defining initial state for z(k) equation with normally distributed noise
% See page 133 of Bolviken paper for information on the system
z(1) = x0(1)*x0(2) + normrnd(0, sqrt(R));

% Iterate through each time step to create simulated values for states
for k=2:N
    % Calculate states at time step k for x(k) equation
    % with normally distributed noise
    x(k,1) = x(k-1,1)*x(k-1,2) + normrnd(0, sqrt(Q));
    x(k,2) = x(k-1,2);
           
    % Calculate state at time step k for z(k) equation
    % with normally distributed noise
    z(k) = x(k,1)*x(k,2) + normrnd(0, sqrt(R));
end

% Store simulated data in csv file for reproducible results
csvwrite('sim_ex7param_true.csv', x); % true state data (x)
csvwrite('sim_ex7param__meas.csv',z); % measurement state data (z)

end
