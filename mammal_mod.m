function dydt = lamprey_mod(t,y,params, I1, I2)
%% Set variable names
V     = y(1); % factor V
Va    = y(2); % factor Va
X     = y(3); % factor X
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
X_up = params(7);
Km_X = params(8);
S = params(9);
P_up = params(10);
TF_VIIa0 = params(11);


%% Model equations
dydt = zeros(length(y), 1);


% Algebraic
a5  = k5 * T; %functional form of a5([T])

a10 = TF_VIIa0; % functional form of a10([TF:VIIa]_0)

%aT  = kT10*Xa./(Km_X + Xa) + kT5*(Xa/(Km_X + Xa))*(Va/(Km_V + Va));%kT5*Va + kT10*Xa; % functional form of aT([Xa],[Va])
aT  = kT10*Xa./(Km_X + Xa)*(1+kT5*min(S,Va)); % functional form of aT([Xa],[Va])

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

% d(VIII)/dt
dydt(7) = aT*P - I2*T - kF*T;

% d(VIIIa)/dt
dydt(8) = aT*P - I2*T - kF*T;

% d(IX)/dt
dydt(9) = aT*P - I2*T - kF*T;

% d(IXa)/dt
dydt(10) = aT*P - I2*T - kF*T;
end