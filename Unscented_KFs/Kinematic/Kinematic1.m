function dydt = Kinematic1(t,y)
% Authors: Lisette de Pillis and Cassidy Le
% Date: November 12, 2019
% Summary:  The 2x2 1st order system representing h'' = -g. Evaluates the
%           kinematics system from the paper by Rhudy, Salguero, and Holappa
%           CITATION: Rhudy, M.B., Salguero, R.A., & Holappa, K. (2017).
%           A Kalman Filtering Tutorial for Undergraduate Students.
%           International Journal of Computer Science & Engineering
%           Survey, 8, 1-18.

% Define constant for gravity
g = 9.81; % gravity units = m/s^2

% Output DE vector consists of velocity y(2) and acceleration (-g)
dydt = [y(2); -g];
end