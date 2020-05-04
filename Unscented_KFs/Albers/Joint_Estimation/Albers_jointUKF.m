% Author: Cassidy Le
% Date: April 11, 2019
% Summary: joint UKF implementation of Albers' et al 2018 T2D model
%          Estimating one state (glucose) and 3 parameters (E, V_i, t_i)
%           CITATION: Albers, D. J., Levine, M. E., Stuart, A., Mamykina,
%           L., Gluckman, B., & Hripcsak, G. (2018). Mechanistic machine
%           learning: How data assimilation leverages physiologic knowledge
%           using Bayesian inference to forecast the future, infer the
%           present, and phenotype. Journal of the American Medical
%           Informatics Association, 25(10), 1392-1401.
%           https://doi.org/10.1093/jamia/ocy106
% Dependencies: AlbersODE.m
%               AlbersTransFcn.m
%               AlbersNoiseFcn_Add.m
%               AlbersMeasFcn.m
%               AlbersParamVals.m
% (if not simulating new data dependencies also include the following
%               Albers_xTrue
%               Albers_yTrue
%               Albers_yMeas
%                           )

% Note: Implementation is based on MATLAB unscentedKalmanFilter example.
%       https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html

% TO DO: if simulating new data, please comment/uncomment out lines of code
%        as instructed.

% Initial conditions taken from Albers code
% I_p = 200 mU
% I_i = 200 mU
% G = 12000 mg dL^(-1)
% h_1 = 0.1 (feeding time delay)
% h_2 = 0.2 (feeding time delay)
% h_3 = 0.1 (feeding time delay)
% Parameter initial condiitons set as actual value b/c these initial
% conditions are used to produce the true values not the measured values
% E = 0.2 L min^(-1)
% V_i = 11 L
% t_i = 100 min
initialStateGuess = [200; 200; 12000; 0.1; 0.2; 0.1; 0.2; 11; 100];

% Defining time interval to filter sample time
% Units of time = [minutes]
timeFinal = 590; % 9 days worth of minutes = 12960 minutes
T = 1; % Size of time step
timeVector = 0:T:timeFinal;

% Create simulated data values (xTrue) by solving system of ODE using ode45
[timeSteps,xTrue]=ode45(@AlbersODE,timeVector,initialStateGuess);

% Read in stored data from csv files for reproducible results
% TO DO: COMMENT OUT NEXT 6 LINES IF YOU WANT TO PRODUCE NEW SIMULATED DATA
xTrue = readtable('Albers_xTrue'); % True state data (with scaled glucose)
xTrue = xTrue{:,:}; % Formats data to matrix
yTrue = readtable('Albers_yTrue'); % True state data (glucose and parameters)
yTrue = yTrue{:,:}; % Formats data to matrix
yMeas = readtable('Albers_yMeas'); % Measurement state data (glucose and parameters)
yMeas = yMeas{:,:}; % Formats data to matrix

% System has 10L of glucose = 100dL
% System computes glucose in units mg dL^(-1) but want units to be mg
% So we have to divide glucose by 100 before running EKF on system
% TO DO: UNCOMMENT THE NEXT LINE IF YOU WANT TO PRODUCE NEW SIMULATED DATA
%xTrue(:,3) = xTrue(:,3)./100; % glucose G

% Moved construction of filter to input different initial state guesses
% This allows EKF and glucTrue to start at same initial values
% Parameter initial condiitons (offset from correct value)
% E = 0.13... actual value = 0.2 L min^(-1)
% V_i = 15... actual value = 11 L
% t_i = 90... actual value = 100 min
initialStateGuess = [200; 200; 120; 0.1; 0.2; 0.1; 0.13; 15; 95];

% Construct the filter
ukf = unscentedKalmanFilter(...
    @AlbersTransFcn,... % State transition function
    @AlbersNoiseFcn_Add,... % Measurement function
    initialStateGuess,... % With glucose in mg L^(-1)
    'HasAdditiveMeasurementNoise',true);

% Setting measurement noise
R = 1.5;
sqrtR = sqrt(R); % Standard deviation of measurement noise
ukf.MeasurementNoise = R; % Variance of measurement noise

% Setting process noise values
% Note: These values are REALLY sensitive. It is important to choose small
%       values. Values that are too large won't allow sufficient smoothing.
%       The algorithm will think the "noisy" measurements are correct.
ukf.ProcessNoise = diag([0.02 0.1 0.04 0.2 0.5 0.01 0.0001 0.0001 0.0001]);

% TO DO: UNCOMMENT THE NEXT LINE IF YOU WANT TO PRODUCE NEW SIMULATED DATA
%rng(1); % Fix random number generator for reproducible results

% Glucose G is the only state we currently measure
% We pretend we measure E, Vi, ti 
% UNCOMMENT THE NEXT LINE IF YOU WANT TO PRODUCE NEW SIMULATED DATA
%yTrue = [xTrue(:,3) xTrue(:,7) xTrue(:,8) xTrue(:,9)];

% Produce simulated noisy measurement data for glucose state variable
% yMeas = yTrue + some noise -> distribution N(mean,sqrtR)
% sqrtR (above) is stadard deviation of measurement noise 
% TO DO: UNCOMMENT THE NEXT LINE IF YOU WANT TO PRODUCE NEW SIMULATED DATA
%yMeas = yTrue + (sqrtR^2*randn(size(yTrue)));

% Iterate through each time step to predict/correct state/parameter values
for k=1:numel(timeSteps)
    % Let k denote the current time.
    % Residuals (or innovations): Measured output - Predicted output
    % ukf.State is x[k|k-1] at this point
    e(k,:) = yMeas(k,:)' - AlbersMeasFcn(ukf.State);
    
    % Predict the states at time step k. 
    [xPredictedUKF(k,:), PPredictedUKF(k,:,:)]=predict(ukf);
    
    % Incorporate measurements at time k into state estimates using
    % the "correct" command. This updates the State and StateCovariance
    % properties of the filter to contain x[k|k] and P[k|k]. These values
    % are also produced as the output of the "correct" command.
    [xCorrectedUKF(k,:), PCorrectedUKF(k,:,:)] = correct(ukf,yMeas(k,:));
    
end

% Plotting glucose estimates and its residuals
figure();
subplot(1,2,1); % plot 1 following
plot(timeVector,xTrue(:,3),'-r', timeVector,xCorrectedUKF(:,3), '--b',...
    timeVector,yMeas(:,1), ':m');
set(gca, 'FontSize', 15);
legend('True','UKF estimate','Measured');
xlabel('Time [min]', 'FontSize', 20);
ylabel('Glucose [mg/L]', 'FontSize', 20);
subplot(1,2,2); % plot 2 following
plot(timeVector, e(:,1), '.');
set(gca, 'FontSize', 15);
xlabel('Time [min]', 'FontSize', 20);
ylabel('Residual (or innovation)', 'FontSize', 20);
suptitle('Glucose estimation');

% Plotting insulin exchange rate (E) estimates and its residuals
figure();
subplot(1,2,1);
plot(timeVector,xTrue(:,7),'-r', timeVector,xCorrectedUKF(:,7), '--b',...
    timeVector,yMeas(:,2), ':m');
set(gca, 'FontSize', 15);
legend('True','UKF estimate','Measured');
xlabel('Time [min]', 'FontSize', 18);
ylabel('Insulin Exchange Rate [L/min]', 'FontSize', 18);
subplot(1,2,2); % plot 2 following
plot(timeVector, e(:,2), '.');
set(gca, 'FontSize', 15);
xlabel('Time [min]', 'FontSize', 18);
ylabel('Residual (or innovation)', 'FontSize', 18);
suptitle('Insulin exchange rate (E) estimation');

% Plotting insulin volume (V_i) estimates and its residuals
figure();
subplot(1,2,1);
plot(timeVector,xTrue(:,8),'-r', timeVector,xCorrectedUKF(:,8), '--b',...
    timeVector,yMeas(:,3), ':m');
set(gca, 'FontSize', 15);
legend('True','UKF estimate','Measured');
xlabel('Time [min]', 'FontSize', 18);
ylabel('Insulin Volume [L]', 'FontSize', 18);
subplot(1,2,2); % plot 2 following
plot(timeVector, e(:,3), '.');
set(gca, 'FontSize', 15);
xlabel('Time [min]', 'FontSize', 18);
ylabel('Residual (or innovation)', 'FontSize', 18);
suptitle('Insulin volume (V_i) estimation');

% Plotting remote insulin degradation time constant (t_i) estimates
% and its resdiauls
figure();
subplot(1,2,1);
plot(timeVector,xTrue(:,9),'-r', timeVector,xCorrectedUKF(:,9), '--b',...
    timeVector,yMeas(:,4), ':m');
set(gca, 'FontSize', 15);
legend('True','UKF estimate','Measured');
xlabel('Time [min]', 'FontSize', 18);
ylabel('Insulin Degradation Time Constant [min]', 'FontSize', 18);
subplot(1,2,2); % plot 2 following
plot(timeVector, e(:,4), '.');
set(gca, 'FontSize', 15);
xlabel('Time [min]', 'FontSize', 18);
ylabel('Residual (or innovation)', 'FontSize', 18);
suptitle('Insulin degradation time constant (t_i) estimation');
