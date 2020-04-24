% Taken from https://www.mathworks.com/help/control/ug/nonlinear-state-estimation-using-unscented-kalman-filter.html

initialStateGuess = [2;0]; % xhat[k|k-1]
% Construct the filter
ukf = unscentedKalmanFilter(...
    @vdpStateFcn,... % State transition function
    @vdpMeasurementNonAdditiveNoiseFcn,... % Measurement function
    initialStateGuess,...
    'HasAdditiveMeasurementNoise',false);

R = 0.2; % Variance of the measurement noise v[k],  original
%R = 0.002; % little measurement noise
%R = .9; % high measurement noise
ukf.MeasurementNoise = R;

ukf.ProcessNoise = diag([0.02 0.1]); %original
%ukf.ProcessNoise = diag([0.9 0.8]); %model is corrected alot
%ukf.ProcessNoise = diag([0.0001 0.0001]); %model is corrected little

%T = 0.05; % [s] Filter sample time
%timeVector = 0:T:5;
T = 0.25; % [s] Filter sample time
timeVector = 0:T:15;
[~,xTrue]=ode45(@vdp1,timeVector,[2;0]);

rng(1); % Fix the random number generator for reproducible results
yTrue = xTrue(:,1);
yMeas = yTrue .* (1+sqrt(R)*randn(size(yTrue))); % sqrt(R): Standard deviation of noise

Nsteps = numel(yMeas); % Number of time steps
xCorrectedUKF = zeros(Nsteps,2); % Corrected state estimates
PCorrected = zeros(Nsteps,2,2); % Corrected state estimation error covariances
e = zeros(Nsteps,1); % Residuals (or innovations)

for k=1:Nsteps
    % Let k denote the current time.
    %
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


figure();
subplot(2,1,1);
plot(timeVector,xTrue(:,1),timeVector,xCorrectedUKF(:,1),timeVector,yMeas(:));
set(gca, 'FontSize', 15);
leg=legend('True','UKF estimate','Measured')
leg.FontSize = 10;
ylim([-2.6 2.6]);
ylabel('x_1', 'FontSize', 15);
subplot(2,1,2);%
plot(timeVector,xTrue(:,2),timeVector,xCorrectedUKF(:,2));
f=legend('True','UKF estimate')
f.FontSize = 10;
set(gca, 'FontSize', 10);
ylim([-3 1.5]);
xlabel('Time [s]', 'FontSize', 15);
ylabel('x_2', 'FontSize', 15);

figure();
plot(timeVector, e, '.');
set(gca, 'FontSize', 15);
xlabel('Time [s]', 'FontSize', 20);
ylabel('Residual (or innovation)', 'FontSize', 20);

%saveas(gcf,'\Users\lindseytam\Desktop\thesis\VDP_highMN_highPN.png')