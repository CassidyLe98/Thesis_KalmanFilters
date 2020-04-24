function [x,z] = sim_gss5(Q,R,m0,P0,N)
% Code taken from Bolviken Appendix A (page 146)
% Summary: Simulates measured (Gaussian) data from Example 5
%          Example is based on Gordon, Salmond & Smith example

% Inputs: Q = 10 in this example
%         R = 1 in this example
%         m0 = mean; 0 in this example
%         P0 = standard deviation; 1 in this example
%         N = number of values produced; 50 in this example

x0 = normrnd(m0, sqrt(P0)); % m0 = mean, P0 = standard deviation
x = zeros(N,1);
z = zeros(N,1);

% Defining initial state for x(k) equation
x(1) = 0.5*x0 + (25*x0/(1 + x0^2)) + 8*cos(1.2*0) + normrnd(0, sqrt(Q));

% Defining initial state for z(k) equation
z(1) = (x(1)^2/20) + normrnd(0, sqrt(R));

for k=2:N
    
    x(k) = 0.5*x(k-1) + (25*x(k-1)/(1 + x(k-1)^2)) + 8*cos(1.2*(k-1)) + normrnd(0, sqrt(Q));
           
    z(k) = (x(k)^2/20) + normrnd(0, sqrt(R));
end

end
