% Author: Lisette de Pillis and Cassidy Le
% Date: November 19, 2019
% Summary:  UKF implementation of Albers' et al 2018 T2D model
%           Estimating one state (glucose)
%           CITATION: Albers, D. J., Levine, M. E., Stuart, A., Mamykina,
%           L., Gluckman, B., & Hripcsak, G. (2018). Mechanistic machine
%           learning: How data assimilation leverages physiologic knowledge
%           using Bayesian inference to forecast the future, infer the
%           present, and phenotype. Journal of the American Medical
%           Informatics Association, 25(10), 1392-1401.
%           https://doi.org/10.1093/jamia/ocy106
% Dependencies: AlbersODE.m
%               AlbersStateFcn.m
%               AlbersNoiseFcn_Add.m
%               AlbersMeasFcn.m
%               AlbersParamVals.m

% Updated by LdP March 14, 2020
% Summary:  Working to fix the large filter shift. The problem is the
%           scaling of the Glucose (3rd state). When we call the AlbersODE
%           function, we need to rescale to. Compute total glucose, and
%           then we need to scale back again to do the fits with glucose
%           per dL so that we match the "data."

% Note: Implementation is based on MATLAB unscentedKalmanFilter example.
%       https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html

% Initial conditions taken from Albers code
% I_p = 200 mU
% I_i = 200 mU
% G = 12000 mg dL^(-1)
% h_1 = 0.1 (feeding time delay)
% h_2 = 0.2 (feeding time delay)
% h_3 = 0.1 (feeding time delay)
initialStateGuess = [200; 200; 12000; 0.1; 0.2; 0.1];

% Defining time interval to filter sample time
% Units of time = [minutes]
timeFinal = 1200; % 9 days worth of minutes = 12960 minutes
T = 1; % Size of time step
timeVector = 0:T:timeFinal;

% Create simulated data values (xTrue) by solving system of ODE using ode45
[timeSteps,xTrue]=ode45(@AlbersODE,timeVector,initialStateGuess);

% System has 10L of glucose = 100dL
% System computes glucose in units mg dL^(-1) but want units to be mg
% So we have to divide glucose by 100 before running EKF on system
glucTrue = xTrue(:,3)./100;

% Moved construction of filter to input different initial state guesses
% This allows UKF and glucTrue to start at same initial values
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

% Setting process noise values
% Note: These values are REALLY sensitive. It is important to choose small
%       values. Values that are too large won't allow sufficient smoothing.
%       The algorithm will think the "noisy" measurements are correct.
ukf.ProcessNoise = diag([0.02 0.1 0.04 0.2 0.5 0.01]);

% Produce simulated noisy measurement data for glucose state variable
rng(1); % Fix the random number generator for reproducible results
% glucMeas = glucTrue + some noise with distribution N(mean,sqrtR) where
% sqrtR is stadard deviation of measurement noise (from line 63)
glucMeas = glucTrue + (sqrtR*randn(size(glucTrue)));

% Iterate through each time step to predict/correct state values using UKF
for k=1:numel(glucMeas)
    % Let k denote the current time.
    % Residuals (or innovations): Measured output - Predicted output
    % ukf.State is x[k|k-1] at this point
    e(k) = glucMeas(k) - AlbersMeasFcn(ukf.State);
    
    % LdeP: Try predicting first, and then correcting. It doesn't seem to
    %       matter in this example whether we predict then correct or
    %       correct then predict.
    
    % Predict the states at time step k. 
    [xPredictedUKF(k,:), PPredictedUKF(k,:,:)]=predict(ukf);
    
    % Incorporate measurements at time k into state estimates using
    % the "correct" command. This updates the State and StateCovariance
    % properties of the filter to contain x[k|k] and P[k|k]. These values
    % are also produced as the output of the "correct" command.
    [xCorrectedUKF(k,:), PCorrected(k,:,:)] = correct(ukf,glucMeas(k));
    
end

% Graph results for glucose state estimates, plotting true values, noisy
% measurement values and UKF estimate values
figure();
plot(timeVector,glucTrue,'-r', timeVector,xCorrectedUKF(:,3), '-b',...
    timeVector,glucMeas, ':m');
set(gca, 'FontSize', 20); % Set size of axis
legend('True','UKF estimate','Measured'); % Label legends
xlabel('Time [min]', 'FontSize', 20); % Label x-axis
ylabel('Glucose [mg/L]', 'FontSize', 20); % Label y-axis

% Graph residuals for glucose state estimates
figure();
plot(timeVector, e, '.');
set(gca, 'FontSize', 15); % Set size of axis
xlabel('Time [min]', 'FontSize', 20); % Label x-axis
ylabel('Residual (or innovation)', 'FontSize', 20); % Label y-axis
