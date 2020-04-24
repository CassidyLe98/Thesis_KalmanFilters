% Author: Cassidy Le
% Date: November 19, 2019
% Summary: UKF implementation of Albers study 2018

% Updated by LdP March 14, 2020
% Summary: Working to fix the large filter shift
% LdP: The problem is the scaling of the Glucose (3rd state)
% When we call the AlbersODE function, we need to rescale to
% compute total glucose, and then we need to scale back again
% to do the fits with glucose per dL so that we match the "data."

% Initial conditions taken from Albers code
% I_p = 200
% I_i = 200
% G = 12000... units = mg dL^(-1)
% h_1 = 0.1
% h_2 = 0.2
% h_3 = 0.1
initialStateGuess = [200; 200; 12000; 0.1; 0.2; 0.1];
timeFinal = 1200; % Units of time = minutes
T = 1; % [s] Filter sample time
timeVector = 0:T:timeFinal;

% Solving system of ODE to produce measurement values
[timeSteps,xTrue]=ode45(@AlbersODE,timeVector,initialStateGuess);

% System has 10L of glucose = 100dL
% We compute total mg of glucose in system but plot mg dL^(-1)
% So we have to divide glucose by 100 before plotting
glucTrue = xTrue(:,3)./100;

% Moved construction of filter to input different initial state guesses
% This allows UKF and yMeas to start at same initial values
initialStateGuess = [200; 200; 120; 0.1; 0.2; 0.1];

% Construct the filter
ukf = unscentedKalmanFilter(...
    @AlbersStateFcn,... % State transition function
    @AlbersNoiseFcn_Add,... % Measurement function
    initialStateGuess,... % With glucose in mg L^(-1)
    'HasAdditiveMeasurementNoise',true);

% Setting measurement noise
sqrtR = 5; % Standard deviation of measurement noise
ukf.MeasurementNoise = sqrtR^2; % Variance of measurement noise

% Too large ProcessNoise won't allow sufficient smoothing
% The algorithm will think the "noisy" measurements are correct.
% small noise -> large gap between measured and UKF estimate
ukf.ProcessNoise = diag([0.02 0.1 0.04 0.2 0.5 0.01]);
% large noise -> UKF estimate follows "noisy" measure so won't smooth as much
% ukf.ProcessNoise = diag([0.3 0.29 0.45 0.42 0.15 0.58]);
% even larger noise values -> reduces gap but makes the filter
% follow the measurement almost exactly, but with additive shift
% ukf.ProcessNoise = diag([0.5 0.99 0.85 0.98 0.50 0.87]);

rng(1); % Fix the random number generator for reproducible results
% glucMeas = glucTrue + some noise -> distribution N(mean,sqrtR)
% sqrtR (above) is stadard deviation of measurement noise
glucMeas = glucTrue + (sqrtR*randn(size(glucTrue)));

for k=1:numel(glucMeas)
    % Let k denote the current time.
    % Residuals (or innovations): Measured output - Predicted output
    % ukf.State is x[k|k-1] at this point
    e(k) = glucMeas(k) - AlbersMeasFcn(ukf.State);
    
    %LdeP: Try predicting first, and then correcting
    % Note: It doesn't seem to matter in this example
    % whether we predict then correct or correct then predict.
    % Predict the states at time step k. 
    [xPredictedUKF(k,:), PPredictedUKF(k,:,:)]=predict(ukf);
    
    % Incorporate measurements at time k into state estimates using
    % the "correct" command. This updates the State and StateCovariance
    % properties of the filter to contain x[k|k] and P[k|k]. These values
    % are also produced as the output of the "correct" command.
    [xCorrectedUKF(k,:), PCorrected(k,:,:)] = correct(ukf,glucMeas(k));
    
end

figure();
plot(timeVector,glucTrue,'-r', timeVector,xCorrectedUKF(:,3), '-b',...
    timeVector,glucMeas, ':m');
set(gca, 'FontSize', 20);
legend('True','UKF estimate','Measured');
xlabel('Time [min]', 'FontSize', 20);
ylabel('Glucose [mg/L]', 'FontSize', 20);

figure();
plot(timeVector, e, '.');
set(gca, 'FontSize', 15);
xlabel('Time [min]', 'FontSize', 20);
ylabel('Residual (or innovation)', 'FontSize', 20);
