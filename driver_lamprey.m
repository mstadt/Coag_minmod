% Driver for running the lamprey model
% Outputs figures for each of the variables

% clear
clearvars;

% Set parameters
p = set_params();

% Change parameter values here
p.kF = 1;

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
I1 = 10;
I2 = 10;

% set simulation time
t0 = 0;
tf = 300;
tspan = [t0,tf];
opts_ode = odeset('RelTol', 1e-6, 'AbsTol', 1e-9, 'MaxStep', 1e-2);

%% Run simulation
[t,y] = ode45(@(t,y) lamprey_mod(t,y,params,...
                        I1, I2),...
                        tspan, IC, opts_ode);

%% Plot results
% fig specs
cmap = summer(4);
c1 = cmap(1,:);
c2 = cmap(3,:);
lw = 4;
fsize = 14;
xlab = 't';

figure(1);
clf;
nr = 3; nc = 2;
tiledlayout(nr,nc);

% factor V
nexttile;
plot(t,y(:,1), 'linewidth', lw, 'color', c1)
xlabel(xlab)
xlim(tspan)
ymin = min([0; y(:,1)]);
ymax = max(y(:,1));
ylim([ymin,ymax])
ylabel('Factor V')
grid on
set(gca,'fontsize',fsize)

% factor Va
nexttile;
plot(t,y(:,2),'linewidth',lw,'color',c1)
xlabel(xlab)
xlim(tspan)
ymin = min([0; y(:,2)]);
ymax = max(y(:,2));
ylim([ymin,ymax])
ylabel('Factor Va')
grid on
set(gca, 'fontsize', fsize)

% factor X
nexttile;
plot(t,y(:,3),'linewidth',lw,'color',c1)
xlabel(xlab)
xlim(tspan)
ymin = min([0; y(:,3)]);
ymax = max(y(:,3));
ylim([ymin,ymax])
ylabel('Factor X')
grid on
set(gca, 'fontsize', fsize)

% factor Xa
nexttile;
plot(t,y(:,4),'linewidth',lw,'color',c1)
ymin = min([0; y(:,4)]);
ymax = max(y(:,4));
ylim([ymin,ymax])
xlabel(xlab)
xlim(tspan)
ylabel('Factor Xa')
grid on
set(gca, 'fontsize', fsize)

% Prothrombin
nexttile;
plot(t,y(:,5),'linewidth',lw,'color',c2)
xlabel(xlab)
ymin = min([0; y(:,5)]);
ymax = max(y(:,5));
ylim([ymin,ymax])
xlim(tspan)
ylabel('Prothrombin')
grid on
set(gca, 'fontsize', fsize)

% Thrombin
nexttile;
plot(t,y(:,6),'linewidth',lw,'color',c2)
xlabel(xlab)
xlim(tspan)
ymin = min([0; y(:,6)]);
ymax = max(y(:,6));
ylim([ymin,ymax])
ylabel('Thrombin')
grid on
set(gca, 'fontsize', fsize)


%% Outputs
% thrombin max and time
T = y(:,6);

[maxT, id] = max(T);

fprintf('time at max(T): %0.2f \n', t(id))
fprintf('max thrombin: %0.4f \n', maxT)
fprintf('steady state thrombin: %0.4f\n', T(end)); 
