function p = set_params_mammal()

% flow
p.kF = 0; %0.1; % flow

% Factor V
p.V_up = 1; 0.1; 
p.k5 = 1;
p.kT5 = 1;
p.Km_V = 0.1;

% Factor Va
p.kT10 = 0.1;


% Factor VIII
p.VIII_up = 0.01; 0.5; 
p.k8 = 1; 

% Factor VIIIa
p.k10_8 = 1; 

% Factor IX
p.IX_up = 1; 1; 
p.k9   = 1; 
p.k10_9 = 0.1; 

% Factor IXa
p.Km_IX = 0.1; 

% Factor X
p.X_up = 10; 1;
p.Km_X = 0.1;
p.S = 0.5; 


% Prothrombin
p.P_up = 100; 10;

% [TF:VIIa]0
p.TF_VIIa0 = 0.01; 0.01;
end