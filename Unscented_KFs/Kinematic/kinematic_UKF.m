% Author: Cassidy Le
% Date: November 12, 2019
% Summary:  UKF implementation of kinematics equation, which is an example
%           from a paper by Rhudy, Salguero, and Holappa
%           CITATION: Rhudy, M.B., Salguero, R.A., & Holappa, K. (2017).
%           A Kalman Filtering Tutorial for Undergraduate Students.
%           International Journal of Computer Science & Engineering
%           Survey, 8, 1-18.
% Dependencies: kinematicStateFcn.m
%               kinematicMeasAdditiveNoiseFcn.m
%               Kinematic1.m
%               kinematicMeasurementFcn.m

% Note: Implementation is based on MATLAB unscentedKalmanFilter example.
%       https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html

% Initial conditions were arbitrarily chosen
% velocity = 2 m/s
% acceleration = 0 m/s^2
initialStateGuess = [2; 0];

% Construct the filter
ukf = unscentedKalmanFilter(...
    @kinematicStateFcn,... % State transition function
    @kinematicMeasAdditiveNoiseFcn,... % Measurement function
    initialStateGuess,...
    'HasAdditiveMeasurementNoise',true);

% Setting measurement noise
R = 0.2; % Variance of the measurement noise v[k]
ukf.MeasurementNoise = R;

% Setting process noise values
% Note: These were chosen arbitrarily, but it is important to choose small
%       values. Values that are too large won't allow sufficient smoothing.
%       The algorithm will think the "noisy" measurements are correct.
ukf.ProcessNoise = diag([0.02 0.1]);

% Defining time interval to filter sample time
% Units of time = [sec]
T = 0.05; % Size of time step
timeVector = 0:T:5;

% Create simulated data values (xTrue) by solving system of ODE using ode45
[~,xTrue]=ode45(@Kinematic1,timeVector,initialStateGuess);

% Produce simulated noisy measurement data for glucose state variable
rng(1); % Fix the random number generator for reproducible results
velocityTrue = xTrue(:,1); % Extract true to only first column (velocity)
% Note: Scaling for simulated true measure does not change proportionally
%       well (e.g. worst case -100*0.1=-10 rather than even boundary width
%       around true). So it should be yMeas = yTrue + some noise with
%       distribution N(mean,sqrtR) where sqrtR is stadard deviation of
%       measurement noise (from line 63). Therefore,
%       noise = 5*(random value between -1 and 1 scaled by sqrtR)
velocityMeas = velocityTrue + 5*(sqrt(R)*randn(size(velocityTrue)));

% Iterate through each time step to predict/correct state values using UKF
for k=1:numel(velocityMeas)
    % Let k denote the current time.
    % Residuals (or innovations) = Measured output - Predicted output
    % ukf.State is x[k|k-1] at this point
    e(k) = velocityMeas(k) - kinematicMeasurementFcn(ukf.State);
    
    % Incorporate the measurements at time k into the state estimates by
    % using the "correct" command. This updates the State and StateCovariance
    % properties of the filter to contain x[k|k] and P[k|k]. These values
    % are also produced as the output of the "correct" command.
    [xCorrectedUKF(k,:), PCorrected(k,:,:)] = correct(ukf,velocityMeas(k));
    
    % Predict the states at next time step, k+1. This updates the State and
    % StateCovariance properties of the filter to contain x[k+1|k] and
    % P[k+1|k]. These will be utilized by the filter at the next time step.
    predict(ukf);
    
end

% Graph results for velocity state estimates, plotting true values, noisy
% measurement values and UKF estimate values
figure();
plot(timeVector,xTrue(:,1),timeVector,xCorrectedUKF(:,1),timeVector,velocityMeas(:));
set(gca, 'FontSize', 15); % Set size of axis
legend('True','UKF estimate','Measured'); % Label legends
xlabel('Time [s]', 'FontSize', 20); % Label x-axis
ylabel('Velocity [m/s]', 'FontSize', 20); % Label y-axis

% Graph residuals for velocity state estimates
figure();
plot(timeVector, e, '.');
set(gca, 'FontSize', 15); % Set size of axis
xlabel('Time [s]', 'FontSize', 20); % Label x-axis
ylabel('Residual (or innovation)', 'FontSize', 20); % Label y-axis
