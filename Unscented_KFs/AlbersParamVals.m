% Author: Cassidy Le
% Date: November 19, 2019
% Summary:  Parameters in AlbersODE.m from Population Physiology (Albers2012)

% No units
a_1 = 6.67; % exponential constant affecting insulin secretion
a = 7.5; % exponential constant affecting insulin dependent glucose utilization
b = 1.77; % exponent affecting insulin dependent glucose utilization

% Units = liters (L)
V_p = 3; % plasma volume
V_i = 11; % insulin volume
V_g = 10; % glucose space

% Units = L min^(-1)
E = 0.2; % exchange rate for insulin between remote/plasma compartments

% Units = min
t_p = 6; % time constant for plasma insulin degradation
t_i = 100; % time constant for remote insulin degradation
t_d = 36; % time delay between plasma insulin and glucose production

% Units = mU min^(-1)
R_m = 209; % linear constant affecting insulin secretion

% Units = mg L^(-1)
C_1 = 300; % exponential constant affecting insulin secretion
C_2 = 144; % exponential constant affecting insulin independent glucose utilization
C_3 = 100; % linear constant affecting insulin dependent glucose utilization

% Units = mU L^(-1)
C_4 = 80; % factor affecting insulin dependent glucose utilization
C_5 = 26; % exponential constant affecting insulin dependent glucose utilization

% Units = mg min^(-1)
U_b = 72; % linear constant effacing insulin independent glucose utilization
U_0 = 4; % linear constant affecting insulin dependent glucose utilization
U_m = 94; % linear constant affecting insulin dependent glucose utilization
R_g = 180; % linear constant affecting insulin dependent glucose utilization
I_g = 216; % exogenous glucose delivery rate (feeding pattern)
