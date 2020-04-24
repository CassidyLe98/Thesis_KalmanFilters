function dydt = AlbersODE(t,y)
% Author: Cassidy Le
% Date: March 31, 2020
% Summary:  Evaluates Albers' ODEs from Population Physiology (Albers2012)

% Inputs:   y = input vector
% Outputs:  set of DEs

% Including file with parameter values
AlbersParamVals;

% Setting y vector input to DE variables
I_p = y(1); I_i = y(2); G = y(3); % states (insulin/glucose)
h_1 = y(4); h_2 = y(5); h_3 = y(6); % states (feeding)
% Add the parameters into input vector when predicting parameters
E = y(7); V_i = y(8); t_i = y(9); % parameters

% ODEs that represent 3-stage linear filters
% Simulates time delay of feeding cycles
dh_1 = 3*(I_p-h_1)/t_d;
dh_2 = 3*(h_1-h_2)/t_d;
dh_3 = 3*(h_2-h_3)/t_d;

% Dynamical system (3 ODEs)
dI_p = R_m/(1+exp(-G/(V_g*C_1)+a_1))-E*((I_p/V_p)-(I_i/V_i))-(I_p/t_p);
dI_i = E*((I_p/V_p)-(I_i/V_i))-(I_i/t_i);
% dG = R_g/(1+exp(a*((h_3/(C_5*V_p))-1)))+I_g-U_b*(1-exp(-G/(C_2*V_g)))-...
%     (1/(C_3*V_g))*(U_0+(U_m-U_0)/(1+((1/C_4)*((1/V_i)-(1/(E*t_i)))*I_i)^(-b)))*G;
% Changed the DEs to be explicitly coded rather than using functions
% dG was set to be equivalent to dx(3) in glucose_insulin.m
dG = R_g/(1+exp(0.29*h_3/V_p-7.5))+I_g-U_b*(1-exp(-G/(C_2*V_g)))-...
    (0.01*G/V_g)*(90/(1+exp(-1.772*log(I_i*(1/V_i+1/(E*t_i)))+7.76))+4);

% Parameters (add when predicting parameters)
% Parameters are constants (unchanging), so equal to 0
dE = 0; % insulin exchange rate between remote/plasma compartments (L/min)
dV_i = 0; % insulin volume (L)
dt_i = 0;  % time constant for remote insulin degradation (min)

% Output DE vector
dydt = [dI_p; dI_i; dG; dh_1; dh_2; dh_3; %];
        % Add parameters in output vector when predicting parameters
        dE; dV_i; dt_i]; 

end
