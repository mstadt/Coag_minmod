function p = set_params()

% flow
p.kF = 0.1; %0.1; % flow

% Factor V
p.V_up = 1; 0.1; 
p.k5 = 1;
p.kT5 = 1;

% Factor Va
p.kT10 = 0.1;

% Factor X
p.X_up = 10; 1;
p.Km_X = 0.1;
p.S = 0.5;


% Prothrombin
p.P_up = 100; 10;

% [TF:VIIa]0
p.TF_VIIa0 = 0.001; 0.01;
end