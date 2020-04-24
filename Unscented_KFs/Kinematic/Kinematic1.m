function dydt = Kinematic1(t,y)
% Authors: LdP and CLe
% Date: November 12, 2019
% Summary:  This function is the 2x2 1st order system representing h'' = -g
%           Comes from the paper by Rhudy, et al AKA "undergrad paper"

g = 9.81; % Gravity m/s^2
dydt = [y(2); -g];
end