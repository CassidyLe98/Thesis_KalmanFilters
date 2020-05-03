function [xhat,P] = ekf_7_noParam(Q,R,m0,P0,N)
% Author: Cassidy Le
% Date: March 29, 2020
% Summary: EKF for Example 7 in Bolviken (page 133) without parameter
%          Code is based on Bolviken code (pages 146-147)
%          https://www.mn.uio.no/math/tjenester/kunnskap/kompendier/komp_kalman.pdf

% Inputs: x = true values; taken from output of sim_gss5
%         z = measured values; taken from output of sim_gss
%         Q = var[w(k)]; 0.01 in this example
%         R = var[v(k)]; 0.02 in this example
%         m0 = mean; 2 in this example
%         P0 = variance; 1 in this example
%         N = number of time steps; 50 in this example
%   Note: w(k) is random term in x(k)
%         v(k) is error term in z(k)
% Outputs:  xhat = EKF estimates for state x
%           zhat = EKF estimates for state z

% Read in stored data from csv files for reproducible results
x = readtable('sim_ex7state_true.csv'); % true state data (x)
x = x{:,:}; % Setting x to be equal to all rows in first column
z = readtable('sim_ex7state_meas.csv'); % measurement state data (z)
z = z{:,:}; % Setting z to be equal to all rows in first column

% Storing dimensions of x and z to use for defining variables
[n,m] = size(x);
[a,b] = size(z);

% Initialize P (EKF estimated matrix of covariance matrices), xhat (EKF
% estimated value of state x), zhat (EKF estimated value of state z) w/ zeros
P = zeros(m*n,m); % Matrix of covariance matrices has m*n rows b/c
xhat = zeros(n,m); % xhat size = x size b/c represents corrected x values
zhat = zeros(a,b); % zhat size = z size b/c represents corrected z values

% Define transition matrix for x as Jacobian of x vector (correction)
Phi = 1;

% Define prediction state for x(k) equation with normally distributed noise
% See page 133 of Bolviken paper for information on the system
x1 = m0;

% Define transition for z as Jacobian of z vector
H = 1;

% Predict initial values for covariance matrix
P1 = Phi*P0*Phi' + Q; % Q incorporates process noise

% Define Kalman gain matrix
S = H*P1*H' + R; % R incorporates measurement noise
K = P1*H'/S;

% Update/correct first value of P, xhat, and zhat
P(1) = (1-K*H)*P1;
xhat(1) = transpose(x1+K*(z(1)-x1(1)));
zhat(1) = xhat(1);

% Iterate through each time step after 1 to estimate states using EKF
for k=2:n
    % Update state transition matrix
    Phi = 1; % Since it's a constant, it remains the same
    
    % Update initial value of x vector
    x1 = xhat(k-1);
    
    % Update transition matrix for z
    H = 1; % Since it's a constant, it remains the same
    
    % Update initial value for covariance matrix
    P1 = Phi*P(k-1)*Phi' + Q;
    
    % Update Kalman gain matrix
    S = H*P1*H' + R;
    K = P1*H'/S;
    
    % Update P, xhat, and zhat
    P(k) = (1-K*H)*P1;
    xhat(k) = transpose(x1+K*(z(k)-x1(1)));
    zhat(k) = xhat(k);
end

% Set time vector in order to graph
timeVector = 1:1:N;

% Create figure for plots
figure();

% First subplot displays EKF estimates for state x
subplot(1,2,1); % creating 1x2 matrix of plots with next plot being 1
plot(timeVector,x,'-r',timeVector,xhat,'-b');
set(gca, 'FontSize', 20); % Set size of axis
legend('xTrue','EKF estimate'); % Label legends
xlabel('Time Step', 'FontSize', 20); % Label and set size of x-axis

% Second subplot displays EKF estimates for state z
subplot(1,2,2); % indicating that the next plot is plot 2
plot(timeVector,z,'-r',timeVector,zhat,'-b');
set(gca, 'FontSize', 20); % Set size of axis
legend('zTrue','EKF estimate'); % Label legends
xlabel('Time Step', 'FontSize', 20); % Label and set size of x-axis

% Include title over figure, centered between the 2 suplots
suptitle('Bolviken Ex7 EKF Estimation of States Only');

end
