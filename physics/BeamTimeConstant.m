% https://me.ucsb.edu/~me105/documents/Beam%20Experiment%20Handout%20(1).pdf
clear;clc;

% material
E = 68.9e9; % Pa;  modulus of elasticity

% shape
% length
L = 40e-3; % meter
% beam cross section
h = 13e-3; % meter. thickness
b = 13e-3; % meter. width

% mass
m = 80e-3; % kg
% -------------- calculation

I = b*h^3/12; % areal moment of inertia
K = 3*E*I/(L^3); % spring constant at the end

omega = sqrt(K/m); % undamped natural frequency

% --------------- disp
tc = 1/omega; 
disp(['undamped time constant: ' num2str(tc*1000) ' ms']);


