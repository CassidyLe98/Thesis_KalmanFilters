function [x,z] = sim_gss7(Q,R,m0,P0,N)
% Author: Cassidy Le
% Date: March 18, 2020
% Summary: Simulates measured (Gaussian) data
%          Code is based on Bolviken code (pages 146-147)

% Inputs: Q = var[w(k)]; 0.1 in this example
%         R = var[v(k)]; 0.2 in this example
%         m0 = mean; [1.85, 0.95] in this example
%         P0 = variance; [1 0; 0 1] in this example
%         N = number of values produced; 50 in this example
%   Note: w(k) is random term in x(k)
%         v(k) is error term in z(k)

x0 = [normrnd(m0(1), sqrt(P0(1,1))); m0(2)];
x = zeros(N,2);
z = zeros(N,1);

% Defining initial state for x(k) equation
x(1,1) = x0(1)*x0(2) + normrnd(0, sqrt(Q));
x(1,2) = x0(2);

% Defining initial state for z(k) equation
z(1) = x0(1)*x0(2) + normrnd(0, sqrt(R));

for k=2:N
    
    x(k,1) = x(k-1,1)*x(k-1,2) + normrnd(0, sqrt(Q));
    x(k,2) = x(k-1,2);
           
    z(k) = x(k,1)*x(k,2) + normrnd(0, sqrt(R));
end

end
