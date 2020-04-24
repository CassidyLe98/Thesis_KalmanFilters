% Author: Cassidy Le
% Date: April 11, 2019
% Summary: joint UKF implementation of Albers study 2018
%          Estimating all states and 3 parameters (E, V_i, t_i)

% Initial conditions taken from Albers code
% I_p = 200
% I_i = 200
% G = 12000... units = mg dL^(-1)
% h_1 = 0.1
% h_2 = 0.2
% h_3 = 0.1
% Parameter initial conditions (correct value for xTrue)
% E = 0.13... actual value = 0.2 L min^(-1)
% V_i = 15... actual value = 11 L
% t_i = 90... actual value = 100 min
initialStateGuess = [200; 200; 12000; 0.1; 0.2; 0.1; 0.2; 11; 100];
timeFinal = 590; % Units of time = minutes
T = 1; % [min] Filter sample time
timeVector = 0:T:timeFinal;

% Solving system of ODE to produce true values (no noise)
[timeSteps,xTrue]=ode45(@AlbersODE,timeVector,initialStateGuess);

% System has 10L of glucose = 100dL
% AlbersODE computes mg/L of glucose but AlbersState computes mg/dL
% Convert L back to dL by dividing by 100
xTrue(:,3) = xTrue(:,3)./100; % glucose G

% Construction of filter has different initial state guesses
% This allows UKF and yMeas to start at same initial values
% Parameter initial conditions (offset from correct value)
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
ukf.ProcessNoise = diag([0.02 0.1 0.04 0.2 0.5 0.01 0.0001 0.0001 0.0001]);

rng(1); % Fix random number generator for reproducible results

% Glucose G is the only state we currently measure
% We pretend we measure E, Vi, ti 
yTrue = [xTrue(:,3) xTrue(:,7) xTrue(:,8) xTrue(:,9)];

% glucMeas = glucTrue + some noise -> distribution N(mean,sqrtR)
% sqrtR (above) is stadard deviation of measurement noise 
yMeas = yTrue + (sqrtR^2*randn(size(yTrue)));

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
