% Author: Cassidy Le
% Date: November 12, 2019
% Summary: UKF implementation of example from undergrad KF tutorial

initialStateGuess = [2; 0]; % xhat[k|k-1]
% Construct the filter
ukf = unscentedKalmanFilter(...
    @kinematicStateFcn,... % State transition function
    @kinematicMeasurementNonAdditiveNoiseFcn,... % Measurement function
    initialStateGuess,...
    'HasAdditiveMeasurementNoise',false);

R = 0.2; % Variance of the measurement noise v[k]
ukf.MeasurementNoise = R;

ukf.ProcessNoise = diag([0.02 0.1]);

T = 0.05; % [s] Filter sample time
timeVector = 0:T:5;
% [~,xTrue]=ode45(@kinematicStateFcn,timeVector,initialStateGuess);
%L deP Trying code with new "Kinematic1" function that has input (t, y) to
% Mirror the vdp1 example.
[~,xTrue]=ode45(@Kinematic1,timeVector,initialStateGuess);

rng(1); % Fix the random number generator for reproducible results
yTrue = xTrue(:,1);
% Scaling for simulated true measure does not change proportionally well
% e.g. worst case -100*0.1=-10 rather than even boundary width around true
% Should be yTrue + some noise
% Noise = 5*(random value between -1 and 1)
yMeas = yTrue + 5*(sqrt(R)*randn(size(yTrue))); % sqrt(R): Standard deviation of noise

for k=1:numel(yMeas)
    % Let k denote the current time.
    % Residuals (or innovations): Measured output - Predicted output
    % ukf.State is x[k|k-1] at this point
    e(k) = yMeas(k) - kinematicMeasurementFcn(ukf.State);
    
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
plot(timeVector,xTrue(:,1),timeVector,xCorrectedUKF(:,1),timeVector,yMeas(:));
set(gca, 'FontSize', 15);
legend('True','UKF estimate','Measured')
xlabel('Time [s]', 'FontSize', 20);
ylabel('Velocity [m/s]', 'FontSize', 20);
%{
subplot(2,1,2);
plot(timeVector,xTrue(:,2),timeVector,xCorrectedUKF(:,2));
ylim([-3 1.5]);
ylabel('x_2');
%}

figure();
plot(timeVector, e, '.');
set(gca, 'FontSize', 15);
xlabel('Time [s]', 'FontSize', 20);
ylabel('Residual (or innovation)', 'FontSize', 20);
