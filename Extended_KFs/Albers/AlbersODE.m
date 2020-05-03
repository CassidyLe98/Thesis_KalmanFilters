function dydt = AlbersODE(t,y)
% Author: LDP and CLe
% Date: November 19, 2019
% Summary:  Evaluates Albers' glucose-insulin physiology model
%           From Albers 2012 Population Physiology model paper
%           CITATION: Albers DJ, Hripcsak G, Schmidt M (2012) Population
%           Physiology: Leveraging Electronic Health Record Data to
%           Understand Human Endocrine Dynamics. PLoS ONE 7(12): e48058.
%           doi:10.1371/journal.pone.0048058
%           Model is based on Sturis, Polonsky, Mosekilde, and Cauter paper
%           CITATION: J. Sturis, K.E.A. (1991). Computer model for mechanisms
%           underlying ultradian oscillations of insulin and glucose.
%           AJP - Endocrinology and Metabolism, 260, E801
%           Also referenced Albers' code glucose_insulin.m in GitHub repo:
%           https://github.com/djalbers/glucose_dynamics_modeling/blob/master/standard_multi_nutrition/glucose_insulin.m
% Dependencies: AlbersParamVals.m

% Inputs:   y = input vector
% Outputs:  set of DEs

% Including file with parameter values
AlbersParamVals;

% Setting y vector input to DE variables to improve readability
I_p = y(1); I_i = y(2); G = y(3); % states (insulin/glucose)
h_1 = y(4); h_2 = y(5); h_3 = y(6); % states (feeding)

% ODEs that represent 3-stage linear filters
% Simulates time delay of 3 feeding cycles
dh_1 = 3*(I_p-h_1)/t_d;
dh_2 = 3*(h_1-h_2)/t_d;
dh_3 = 3*(h_2-h_3)/t_d;

% ODEs representing plasma insulin, remote insulin, and glucose states
dI_p = R_m/(1+exp(-G/(V_g*C_1)+a_1))-E*((I_p/V_p)-(I_i/V_i))-(I_p/t_p); % plasma insulin
dI_i = E*((I_p/V_p)-(I_i/V_i))-(I_i/t_i); % remote insulin
% Note: Equation dG does not align with Albers 2012 equations
%       Model is based on Sturis, Polonsky, Mosekilde, and Cauter paper
%       CITATION: J. Sturis, K.E.A. (1991). Computer model for mechanisms
%       underlying ultradian oscillations of insulin and glucose.
%       AJP - Endocrinology and Metabolism, 260, E801
%       Set to be equivalent to Sturis dz/dt equation in Appendix
%       Also set to equal dx(3) in Albers' code glucose_insulin.m
%       https://github.com/djalbers/glucose_dynamics_modeling/blob/master/standard_multi_nutrition/glucose_insulin.m
dG = R_g/(1+exp(0.29*h_3/V_p-7.5))+I_g-U_b*(1-exp(-G/(C_2*V_g)))-...
    (0.01*G/V_g)*(90/(1+exp(-1.772*log(I_i*(1/V_i+1/(E*t_i)))+7.76))+4); % glucose

% Output DE vector
dydt = [dI_p; dI_i; dG; % states (insulin/glucose)
        dh_1; dh_2; dh_3]; % states (feeding)

end
