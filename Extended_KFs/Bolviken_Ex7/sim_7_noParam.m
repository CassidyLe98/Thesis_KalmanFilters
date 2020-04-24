function [x,z] = sim_7_noParam(Q,R,m0,P0,N)
% Author: Cassidy Le
% Date: March 29, 2020
% Summary: Simulates measured (Gaussian) data for Bolviken Ex7
%          Without predicting parameter
%          Code is based on Bolviken code (pages 146-147)

% Inputs: Q = var[w(k)]; 0.01 in this example
%         R = var[v(k)]; 0.02 in this example
%         m0 = mean; 2 in this example
%         P0 = variance; 1 in this example
%         N = number of values produced; 50 in this example
%   Note: w(k) is random term in x(k)
%         v(k) is error term in z(k)

x0 = normrnd(m0, sqrt(P0));
x = zeros(N,1);
z = zeros(N,1);

% Defining initial state for x(k) equation
x(1) = x0(1) + normrnd(0, sqrt(Q));

% Defining initial state for z(k) equation
z(1) = x0(1) + normrnd(0, sqrt(R));

for k=2:N
    
    x(k) = x(k-1) + normrnd(0, sqrt(Q));
           
    z(k) = x(1) + normrnd(0, sqrt(R));
end

% Writes output matrix as csv file
% csvwrite('sim_gss.csv',[x,z]);

end
