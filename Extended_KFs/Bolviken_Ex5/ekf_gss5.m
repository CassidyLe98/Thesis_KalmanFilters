function [xhat,P] = ekf_gss5(Q,R,m0,P0,N)
% Code taken from Bolviken Appendix A (page 146-147)
% Summary: EKF for Gordon, Salmond & Smith example
%          Gordon, Salmond & Smith example based on

% Inputs: x = true values; taken from output of sim_gss5
%         z = measured values; taken from output of sim_gss
%         Q = var[w(k)]; 10 in this example
%         R = var[v(k)]; 1 in this example
%         m0 = mean; 0 in this example
%         P0 = standard deviation; 1 in this example
%         N = number of time steps; 50 in this example

x = readtable('book_example_value_true.csv'); % true
x = x{:,1};
z = readtable('book_example_value_meas.csv'); % meas
z = z{:,1};

[n,m] = size(x);
P = zeros(n,m); % same size as x since single state model
xhat = zeros(n,m); % same size as x
zhat = zeros(n,m);

Phi = 0.5 + (25-25*m0^2)/(1 + m0^2)^2; % Jacobian of x vector (correction)
x1 = 0.5*m0 + 25*m0/(1+m0^2) + 8*cos(1.2*0); % prediction of x vector
H = x1/10; % Jacobian of z vector
P1 = Phi*P0*Phi + Q; % Q incorporates process noise
S = H*P1*H + R; % R incorporates measurement noise
K = P1*H/S;
P(1) = (1-K*H)*P1;
xhat(1) = x1 + K*(z(1)-x1^2/20);
zhat(1) = x1^2/20;

for k=2:n
    Phi = 0.5+(25-25*xhat(k-1)^2)/(1+xhat(k-1)^2)^2;
    x1 = 0.5*xhat(k-1) + (25*xhat(k-1)/(1+xhat(k-1)^2)) + 8*cos(1.2*(k-1));
    H = x1/10;
    P1 = Phi*P(k-1)*Phi + Q;
    S = H*P1*H + R;
    K = P1*H/S;
    P(k) = (1-K*H)*P1;
    xhat(k) = x1 + K*(z(k)-x1^2/20);
    zhat(k) = x1^2/20;
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

%suptitle('Bolviken Ex5 EKF Estimation of States Only');

end
