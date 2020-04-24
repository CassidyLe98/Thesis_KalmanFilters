function [xhat,P] = ekf_7_noParam(Q,R,m0,P0,N)
% Author: Cassidy Le
% Date: March 29, 2020
% Summary: EKF for Example 7 in Bolviken (page 133) without parameter
%          Code is based on Bolviken code (pages 146-147)

% Inputs: x = true values; taken from output of sim_gss5
%         z = measured values; taken from output of sim_gss
%         Q = var[w(k)]; 0.01 in this example
%         R = var[v(k)]; 0.02 in this example
%         m0 = mean; 2 in this example
%         P0 = variance; 1 in this example
%         N = number of time steps; 50 in this example

x = readtable('sim_ex7state_true.csv'); % true
x = x{:,:};
z = readtable('sim_ex7state_meas.csv'); % meas
z = z{:,:};

[n,m] = size(x);
[a,b] = size(z);
P = zeros(m*n,m); % matrix of covariance matrices
xhat = zeros(n,m); % same size as x
zhat = zeros(a,b); % same size as z

Phi = 1; % Jacobian of x vector
x1 = m0; % prediction of x vector
H = 1; % Jacobian of z vector

P1 = Phi*P0*Phi' + Q;
S = H*P1*H' + R;
K = P1*H'/S;
P(1) = (1-K*H)*P1;
xhat(1) = transpose(x1+K*(z(1)-x1(1)));
zhat(1) = xhat(1);

for k=2:n
    Phi = 1;
    x1 = xhat(k-1);
    H = 1;
    
    P1 = Phi*P(k-1)*Phi' + Q;
    S = H*P1*H' + R;
    K = P1*H'/S;
    P(k) = (1-K*H)*P1;
    xhat(k) = transpose(x1+K*(z(k)-x1(1)));
    zhat(k) = xhat(k);
end

timeVector = 1:1:N;

figure();

subplot(1,2,1); % creating 1x2 matrix of plots with next plot being 1
plot(timeVector,x,'-r',timeVector,xhat,'-b');
set(gca, 'FontSize', 20);
legend('xTrue','EKF estimate');
xlabel('Time Step', 'FontSize', 20);

subplot(1,2,2); % indicating that the next plot is plot 2
plot(timeVector,z,'-r',timeVector,zhat,'-b');
set(gca, 'FontSize', 20);
legend('zTrue','EKF estimate');
xlabel('Time Step', 'FontSize', 20);

% Title over all subplots
% suptitle('Bolviken Ex7 EKF Estimation of States Only');

end
