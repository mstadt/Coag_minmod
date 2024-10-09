function dydt = mammal_mod(t,y,params, I1, I2)
%% Set variable names
V     = y(1); % factor V
Va    = y(2); % factor Va
X     = y(3); % factox  r X
Xa    = y(4); % factor Xa
P     = y(5); % prothrombin
T     = y(6); % thrombin
VIII  = y(7); % factor VIII
VIIIa = y(8); % factor VIIIa
IX    = y(9); % factor IX
IXa   = y(10); %factor IXa



%% Set parameter names
% NOTE: update updatepars.m to get parameter list from set_params()
kF = params(1);
V_up = params(2);
k5 = params(3);
kT5 = params(4);
Km_V = params(5);
kT10 = params(6);
VIII_up = params(7);
k8 = params(8);
k10_8 = params(9);
IX_up = params(10);
k9 = params(11);
k10_9 = params(12);
Km_IX = params(13);
X_up = params(14);
Km_X = params(15);
S = params(16);
P_up = params(17);
TF_VIIa0 = params(18);


%% Model equations
dydt = zeros(length(y), 1);


% Algebraic
a5  = k5 * T; %functional form of a5([T])

a10 = TF_VIIa0; % functional form of a10([TF:VIIa]_0)

Km_V = S/2; % functional form of Km_V based on surface argument; 

aT  = kT10*Xa./(Km_X + Xa) + kT5*(Xa/(Km_X + Xa))*(Va/(Km_V + Va));%kT5*Va + kT10*Xa; % functional form of aT([Xa],[Va])

Km_VIII = S/2; 

a10_8  = k10_9*IXa./(Km_IX + IXa) + k10_8*IXa./(Km_IX + IXa)*(VIIIa/(Km_VIII + VIIIa));%kT5*Va + kT10*Xa; % functional form of aT([Xa],[Va])

a8  = k8 * T; %functional form of a8([T])

a9  = k9 * T; %functional form of a9([T])
% ODES
% d(V)/dt
dydt(1) = kF*(V_up - V) - a5*V;

% d(Va)/dt
dydt(2) = a5*V;  % - kF*Va;

% d(X)/dt
dydt(3) = kF*(X_up - X) - a10*X;

% d(Xa)/dt 
dydt(4) = a10*X - I1*Xa + a10_8*X; %- kF*Xa;

% d(P)/dt
dydt(5) = kF*(P_up - P) - aT*P;
    
% d(T)/dt
dydt(6) = aT*P - I2*T - kF*T;

% d(VIII)/dt
dydt(7) = kF*(VIII_up - VIII) - a8*VIII; 

% d(VIIIa)/dt
dydt(8) = a8*VIII; 

% d(IX)/dt
dydt(9) = kF*(IX_up - IX) - a9*IX; 

% d(IXa)/dt
dydt(10) = a9*IX;
end