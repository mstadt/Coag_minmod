function dydt = lamprey_mod(t,y,params, I1, I2)
%% Set variable names
V     = y(1); % factor V
Va    = y(2); % factor Va
X     = y(3); % factor X
Xa    = y(4); % factor Xa
P     = y(5); % prothrombin
T     = y(6); % thrombin

%% Set parameter names
% NOTE: update updatepars.m to get parameter list from set_params()
kF = params(1);
V_up = params(2);
k5 = params(3);
kT5 = params(4);
kT10 = params(5);
X_up = params(6);
Km_X = params(7);
S = params(8);
P_up = params(9);
TF_VIIa0 = params(10);

%% Model equations
dydt = zeros(length(y), 1);


% Algebraic
a5  = k5 * T; %functional form of a5([T])

a10 = TF_VIIa0; % functional form of a10([TF:VIIa]_0)

Km_V = S/2; % functional form of Km_V based on surface argument; 

aT  = kT10*Xa./(Km_X + Xa) + kT5*(Xa/(Km_X + Xa))*(Va/(Km_V + Va));%kT5*Va + kT10*Xa; % functional form of aT([Xa],[Va])

% ODES
% d(V)/dt
dydt(1) = kF*(V_up - V) - a5*V;

% d(Va)/dt
dydt(2) = a5*V;  % - kF*Va;

% d(X)/dt
dydt(3) = kF*(X_up - X) - a10*X;

% d(Xa)/dt 
dydt(4) = a10*X - I1*Xa; %- kF*Xa;

% d(P)/dt
dydt(5) = kF*(P_up - P) - aT*P;

% d(T)/dt
dydt(6) = aT*P - I2*T - kF*T;
end