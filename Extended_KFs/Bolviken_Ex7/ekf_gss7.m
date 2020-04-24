function [xhat,P] = ekf_gss7(Q,R,m0,P0,N)
% Author: Cassidy Le
% Date: March 19, 2020
% Summary: EKF for Example 7 in Bolviken (page 133)
%          Code is based on Bolviken code (pages 146-147)

% Inputs: x = true values; taken from output of sim_gss5
%         z = measured values; taken from output of sim_gss
%         Q = var[w(k)]; 0.01 in this example
%         R = var[v(k)]; 0.02 in this example
%         m0 = mean; [2 1] in this example
%         P0 = variance; [1 0; 0 1] in this example
%         N = number of time steps; 50 in this example

x = readtable('sim_ex7param_true.csv'); % true
x = x{:,:};
z = readtable('sim_ex7param_meas.csv'); % meas
z = z{:,:};

[n,m] = size(x);
[a,b] = size(z);
P = zeros(m*n,m); % matrix of covariance matrices
xhat = zeros(n,m); % same size as x
zhat = zeros(a,b); % same size as z

Phi = [m0(2) m0(1); 0 1]; % Jacobian of x vector
x1 = [m0(1)*m0(2); m0(2)]; % prediction of x vector
H = [m0(2), m0(1)]; % Jacobian of z vector

P1 = Phi*P0*Phi' + Q;
S = H*P1*H' + R;
K = P1*H'/S;
P(1:2,:) = (1-K*H)*P1;
xhat(1,:) = transpose(x1+K*(z(1)-x1(1)));
zhat(1) = xhat(1,1)*xhat(1,2);

for k=2:n
    Phi = [xhat(k-1,2) xhat(k-1,1); 0 1];
    x1 = [xhat(k-1,1)*xhat(k-1,2); xhat(k-1,2)];
    H = [x1(2), x1(1)];
    P1 = Phi*P(k-1:k,:)*Phi' + Q;
    S = H*P1*H' + R;
    K = P1*H'/S;
    P(k+1:k+2,:) = (1-K*H).*P1;
    xhat(k,:) = transpose(x1+K*(z(k)-x1(1)));
    zhat(k) = xhat(k,1)*xhat(k,2);
end

timeVector = 1:1:N;

figure();

subplot(1,3,1); % creating 1x3 matrix of plots with next plot being 1
plot(timeVector,x(:,1),'-r',timeVector,xhat(:,1),'-b');
set(gca, 'FontSize', 20);
legend('xTrue','EKF estimate');
xlabel('Time Step', 'FontSize', 20);

subplot(1,3,2); % indicating that the next plot is plot 2
plot(timeVector,z,'-r',timeVector,zhat,'-b');
set(gca, 'FontSize', 20);
legend('zTrue','EKF estimate');
xlabel('Time Step', 'FontSize', 20);

subplot(1,3,3); % indicating that the next plot is plot 3
plot(timeVector,x(:,2),'-r',timeVector,xhat(:,2),'-b');
set(gca, 'FontSize', 20);
legend('True Parameter Value','EKF estimate');
xlabel('Time Step', 'FontSize', 20);

end
