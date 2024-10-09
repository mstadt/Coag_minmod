function p = set_params()

% flow
p.kF = 0; %0.1; % flow

% Factor V
p.V_up = 1; 
p.k5 = 1;
p.kT5 = 0.1;
p.Km_V = 0.1;

% Factor Va
p.kT10 = 0.1;


% Factor VIII
p.VIII_up = 1; 
p.kT8 = 1; 

% Factor VIIIa
p.k10_8 = 0.1; 

% Factor IX
p.IX_up = 1; 
p.kT9 = 0.1; 

% Factor X
p.X_up = 1;
p.Km_X = 0.1;
p.S = 0.5; 


% Prothrombin
p.P_up = 1;

% [TF:VIIa]0
p.TF_VIIa0 = 1;
end