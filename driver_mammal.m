% Driver for running the lamprey model
% Outputs figures for each of the variables

% clear
clearvars;

% Set parameters
p = set_params_mammal();

p.kF = 1; 
% Change parameter values here

[params, parnames] = pars2vector(p,0);

% Set initial conditions
V0  = 0.1;
Va0 = 0;
X0  = 1;
Xa0 = 0;
P0  = 10;
T0  = 0;
VIII0 = 1; 
VIIIa0 = 0; 
IX0    = 1; 
IXa0   = 0; 
IC = [V0; Va0; X0; Xa0; P0; T0; VIII0; VIIIa0; IX0; IXa0];

% inhibitors
I1 = 10;
I2 = 10;

% set simulation time
t0 = 0;
tf = 100;
tspan = [t0,tf];
opts_ode = odeset('RelTol', 1e-6, 'AbsTol', 1e-9, 'MaxStep', 1e-2);

%% Run simulation
[t,y] = ode45(@(t,y) mammal_mod(t,y,params,...
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
nr = 5; nc = 2;
tiledlayout(nr,nc);
set(gcf,'Position',[440    76   922   721])

% factor V
nexttile;
plot(t,y(:,1), 'linewidth', lw, 'color', c1)
xlabel(xlab)
xlim(tspan)
ylabel('Factor V')
grid on
set(gca,'fontsize',fsize)

% factor Va
nexttile;
plot(t,y(:,2),'linewidth',lw,'color',c1)
xlabel(xlab)
xlim(tspan)
ylabel('Factor Va')
grid on
set(gca, 'fontsize', fsize)

% factor X
nexttile;
plot(t,y(:,3),'linewidth',lw,'color',c1)
xlabel(xlab)
xlim(tspan)
ylabel('Factor X')
grid on
set(gca, 'fontsize', fsize)

% factor Xa
nexttile;
plot(t,y(:,4),'linewidth',lw,'color',c1)
xlabel(xlab)
xlim(tspan)
ylabel('Factor Xa')
grid on
set(gca, 'fontsize', fsize)

% Factor VIII
nexttile;
plot(t,y(:,7),'linewidth',lw,'color',c1)
xlabel(xlab)
xlim(tspan)
ylabel('Factor VIII')
grid on
set(gca, 'fontsize', fsize)


% Factor VIII
nexttile;
plot(t,y(:,8),'linewidth',lw,'color',c1)
xlabel(xlab)
xlim(tspan)
ylabel('Factor VIIIa')
grid on
set(gca, 'fontsize', fsize)

% Factor IX
nexttile;
plot(t,y(:,9),'linewidth',lw,'color',c1)
xlabel(xlab)
xlim(tspan)
ylabel('Factor IX')
grid on
set(gca, 'fontsize', fsize)


% Factor IXa
nexttile;
plot(t,y(:,10),'linewidth',lw,'color',c1)
xlabel(xlab)
xlim(tspan)
ylabel('Factor IXa')
grid on
set(gca, 'fontsize', fsize)

% Prothrombin
nexttile;
plot(t,y(:,5),'linewidth',lw,'color',c2)
xlabel(xlab)
xlim(tspan)
ylabel('Prothrombin')
grid on
set(gca, 'fontsize', fsize)

% Thrombin
nexttile;
plot(t,y(:,6),'linewidth',lw,'color',c2)
xlabel(xlab)
xlim(tspan)
ylabel('Thrombin')
grid on
set(gca, 'fontsize', fsize)


%% Outputs
% thrombin max and time
T = y(:,6);

[maxT, id] = max(T);

fprintf('time at max(T): %0.2f \n', t(id))
fprintf('max thrombin: %0.4f \n', maxT)
