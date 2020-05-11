% Summary:  UKF implementation of Van der Pol oscillator for mu = 1
% Output:   Graphed results of UKF estimates for velocity of Van der Pol
%           oscillator as well as residuals of those estimates
% Dependencies: vdpStateFcn.m
%               vdpMeasurementNonAdditiveNoiseFcn.m
%               vdp1.m
%               vdpMeasurementFcn.m

% Note: Implementation is taken from MATLAB unscentedKalmanFilter example.
%       https://www.mathworks.com/help/control/ug/nonlinear-state-estimation-using-unscented-kalman-filter.html

% Set initial conditions
initialStateGuess = [2;0]; % xhat[k|k-1]

% Construct the filter
ukf = unscentedKalmanFilter(...
    @vdpStateFcn,... % State transition function
    @vdpMeasurementNonAdditiveNoiseFcn,... % Measurement function
    initialStateGuess,...
    'HasAdditiveMeasurementNoise',false); % False b/c noise is multiplicative

% Set measurement noise
R = 0.2; % Variance of the measurement noise v[k]
ukf.MeasurementNoise = R;

% Setting process noise values
% Note: These were chosen arbitrarily, but it is important to choose
%       sufficiently small values. Values that are too large will correct
%       a lot but won't allow sufficient smoothing. The algorithm will
%       think the "noisy" measurements are correct. Really small process
%       noise will not correct enough. See commented code in lines 31 and
%       32 to see how adjusting ProcessNoise affects the model.
ukf.ProcessNoise = diag([0.02 0.1]); % original
%ukf.ProcessNoise = diag([0.9 0.8]); % model is corrected a lot
%ukf.ProcessNoise = diag([0.0001 0.0001]); % model is corrected little

% Defining time interval to filter sample time
% Units of time = [secs]
T = 0.05; % Size of time step
timeVector = 0:T:5;

% Create simulated data values (xTrue) by solving system of ODE using ode45
[~,xTrue]=ode45(@vdp1,timeVector,initialStateGuess);

% Produce simulated noisy measurement data for glucose state variable
rng(1); % Fix the random number generator for reproducible results
yTrue = xTrue(:,1); % Extract yTrue to only first column (velocity)
% yMeas = yTrue + some noise with distribution N(mean,sqrt(R)) where
% sqrt(R) is stadard deviation of measurement noise (from line 21)
yMeas = yTrue .* (1+sqrt(R)*randn(size(yTrue)));

% Initializing variables for UKF corrected state estimates, UKF corrected
% covariance estimates, and residuals
Nsteps = numel(yMeas); % Number of time steps
xCorrectedUKF = zeros(Nsteps,2); % Corrected state estimates
PCorrected = zeros(Nsteps,2,2); % Corrected state estimation error covariances
e = zeros(Nsteps,1); % Residuals (or innovations)

% Iterate through each time step to predict/correct state values using UKF
for k=1:Nsteps
    % Let k denote the current time.
    
    % Residuals (or innovations): Measured output - Predicted output
    e(k) = yMeas(k) - vdpMeasurementFcn(ukf.State); % ukf.State is x[k|k-1] at this point
    
    % Incorporate the measurements at time k into the state estimates by
    % using the "correct" command. This updates the State and StateCovariance
    % properties of the filter to contain x[k|k] and P[k|k]. These values
    % are also produced as the output of the "correct" command.
    [xCorrectedUKF(k,:), PCorrected(k,:,:)] = correct(ukf,yMeas(k));
    
    % Predict the states at next time step, k+1. This updates the State and
    % StateCovariance properties of the filter to contain x[k+1|k] and
    % P[k+1|k]. These will be utilized by the filter at the next time step.
    predict(ukf);
end

% Graph results for velocity state estimates and acceleration, plotting
% true values of velocity/acceleration, noisy measurement values for velocity
% and acceleration, and UKF estimate values for velocity
figure();
subplot(2,1,1); % Creating verticle subplots, next plot is first plot (velocity)
plot(timeVector,xTrue(:,1),timeVector,xCorrectedUKF(:,1),timeVector,yMeas(:));
set(gca, 'FontSize', 15);
leg = legend('True','UKF estimate','Measured')
leg.FontSize = 15;
ylim([-2.6 2.6]);
ylabel('x_1', 'FontSize', 15);
subplot(2,1,2); % Second subplot (acceleration)
plot(timeVector,xTrue(:,2),timeVector,xCorrectedUKF(:,2));
%f = legend('True','UKF estimate')
%f.FontSize = 10;
set(gca, 'FontSize', 15);
ylim([-3 1.5]);
xlabel('Time [s]', 'FontSize', 15);
ylabel('x_2', 'FontSize', 15);

% Graph residuals for velocity state estimates
figure();
plot(timeVector, e, '.');
set(gca, 'FontSize', 15);
xlabel('Time [s]', 'FontSize', 20);
ylabel('Residual (or innovation)', 'FontSize', 20);
