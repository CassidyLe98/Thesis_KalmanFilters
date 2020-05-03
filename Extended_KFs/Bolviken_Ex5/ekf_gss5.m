function [xhat,P] = ekf_gss5(Q,R,m0,P0,N)
% Date: April 3, 2020
% Summary:  EKF for Bolviken Example 5.
%           Example based on Gordon, Salmond & Smith example (cited below)
%           CITATION:  N. Gordon, D. Salmond, and A. F. M. Smith. Novel
%           approach to nonlinear/nonGaussian Bayesian state estimation.
%           IEE Proceedings-F, 140(2):107?113, 1993.
% Dependencies: sim_ex5_true.csv
%               sim_ex5_meas.csv

% Code taken from Bolviken Appendix A (page 146-147)
% https://www.mn.uio.no/math/tjenester/kunnskap/kompendier/komp_kalman.pdf

% Inputs: x = true values; taken from output of sim_gss5
%         z = measured values; taken from output of sim_gss
%         Q = var[w(k)]; 10 in this example
%         R = var[v(k)]; 1 in this example
%         m0 = mean; 0 in this example
%         P0 = standard deviation; 1 in this example
%         N = number of time steps; 50 in this example
% Outputs:  xhat = EKF estimates for state x
%           zhat = EKF estimates for state z

% Read in stored data from csv files for reproducible results
x = readtable('sim_ex5_true.csv'); % true state data (x)
x = x{:,1}; % Setting x to be equal to all rows in first column
z = readtable('sim_ex5__meas.csv'); % measurement state data (z)
z = z{:,1}; % Setting z to be equal to all rows in first column

% Initialize P, xhat, and zhat with zeros
[n,m] = size(x); % Store size of x to use for defining variables
P = zeros(n,m); % Same size as x since the system is a single state model
xhat = zeros(n,m); % xhat size = x size b/c represents corrected x values
zhat = zeros(n,m); % zhat size = z size = x size

% Define transition matrix for x as Jacobian of x vector (correction)
Phi = 0.5 + (25-25*m0^2)/(1 + m0^2)^2;

% Predict initial value of x vector
x1 = 0.5*m0 + 25*m0/(1+m0^2) + 8*cos(1.2*0);

% Define transition for z as Jacobian of z vector
H = x1/10;

% Predict initial values for covariance matrix
P1 = Phi*P0*Phi + Q; % Q incorporates process noise

% Define Kalman gain matrix
S = H*P1*H + R; % R incorporates measurement noise
K = P1*H/S;

% Update/correct first value of P (EKF estiamted covariance matrix), xhat
% (EKF estimated value of state x), zhat (EKF estimated value of state z)
P(1) = (1-K*H)*P1;
xhat(1) = x1 + K*(z(1)-x1^2/20);
zhat(1) = x1^2/20;

% Iterate through each time step after 1 to estimate states using EKF
for k=2:n
    % Update state transition matrix
    Phi = 0.5+(25-25*xhat(k-1)^2)/(1+xhat(k-1)^2)^2;
    
    % Update initial value of x vector
    x1 = 0.5*xhat(k-1) + (25*xhat(k-1)/(1+xhat(k-1)^2)) + 8*cos(1.2*(k-1));
    
    % Update transition matrix for z
    H = x1/10;
    
    % Update initial value for covariance matrix
    P1 = Phi*P(k-1)*Phi + Q;
    
    % Update Kalman gain matrix
    S = H*P1*H + R;
    K = P1*H/S;
    
    % Update P, xhat, and zhat
    P(k) = (1-K*H)*P1;
    xhat(k) = x1 + K*(z(k)-x1^2/20);
    zhat(k) = x1^2/20;
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
suptitle('Bolviken Ex5 EKF Estimation of States Only');

end
