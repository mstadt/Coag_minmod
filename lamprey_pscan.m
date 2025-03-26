% Driver for running the lamprey model
% Scans dependence on kf

function [t, T] = lamprey_pscan(kflow, TF_VIIa)

% Set parameters
p = set_params();

% Change parameter values here

p.kF = kflow;
p.TF_VIIa0 = TF_VIIa;

[params, parnames] = pars2vector(p,0);

% Set initial conditions
V0  = 1; 0.1;
Va0 = 0;
X0  = 10;
Xa0 = 0;
P0  = 100;
T0  = 0;
IC = [V0; Va0; X0; Xa0; P0; T0];

% inhibitors
I1 = 100;
I2 = 100;

% set simulation time
t0 = 0;
tf = 1000;
tspan = [t0,tf];
opts_ode = odeset('RelTol', 1e-6, 'AbsTol', 1e-9, 'MaxStep', 1e-2);

%% Run simulation
[t,y] = ode45(@(t,y) lamprey_mod(t,y,params,...
                        I1, I2),...
                        tspan, IC, opts_ode);

T = y(:,6);

end