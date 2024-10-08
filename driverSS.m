% Driver for finding the lamprey model steady state
% Outputs figures for each of the variables

% clear
clearvars;

% Set parameters
p = set_params();

% Change parameter values here
p.kF = 0.1; % flow

% factor V
p.V_up = 1; 
p.k5 = 1;
p.kT5 = 0.1;

% factor X
p.kT10 = 0.1;
p.X_up = 1;

% prothrombin
p.P_up = 1;

p.TF_VIIa0 = 1;


[params, parnames] = pars2vector(p,0);

% Set initial conditions
V0  = 1;
Va0 = 0;
X0  = 1;
Xa0 = 0;
P0  = 1;
T0  = 0;
IC = [V0; Va0; X0; Xa0; P0; T0];

% inhibitors
I1 = 0.1;
I2 = 0.1;

% set simulation time
t0 = 0;
tf = 1e3;
tspan = [t0,tf];
opts_ode = odeset('RelTol', 1e-6, 'AbsTol', 1e-9, 'MaxStep', 1e-2);

%% Run simulation
[t,y] = ode45(@(t,y) lamprey_mod(t,y,params,...
                        I1, I2),...
                        tspan, IC, opts_ode);

%% Get end point
IG = y(end,:); % initial guess

opts_fsolve = optimoptions('fsolve','Display', 'none',...
                                'MaxFunEvals', 1e6,...
                                'MaxIter', 1e6,...
                                'FunctionTolerance', 1e-16);

% Find steady state
[SSdat, residual, ....
    exitflag, output] = fsolve(@ (y) lamprey_mod(0, y, params, ...
                                    I1, I2),...
                                    IG, opts_fsolve);
fprintf('maximum residual size: %0.1d \n', max(abs(residual)))

if exitflag ~= 1
    fprintf('WARNING: SS did not converge exitflag: %i \n', exitflag)
end

% Print out solution
if exitflag == 1
    % Print steady state solutions
    fprintf('SS solution \n')
    fprintf('V:     %0.3f\n', SSdat(1))
    fprintf('Va:    %0.3f\n', SSdat(2))
    fprintf('X:     %0.3f\n', SSdat(3))
    fprintf('Xa:    %0.3f\n', SSdat(4))
    fprintf('P:     %0.3f\n', SSdat(5))
    fprintf('T:     %0.3f\n', SSdat(6))
end
