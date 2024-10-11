%
% Thrombin production vs kF
%
%   10/10/2024
%

veckF = [0 1 100];

TSS_lamprey = zeros(size(veckF));
TSS_mammal = zeros(size(veckF));

Tmax_lamprey = zeros(size(veckF));
Tmax_mammal = zeros(size(veckF));

tTSS_lamprey = zeros(size(veckF));
tTSS_mammal = zeros(size(veckF));

% set simulation time
t0 = 0;
tf = 300;
tspan = [t0,tf];
opts_ode = odeset('RelTol', 1e-6, 'AbsTol', 1e-9, 'MaxStep', 1e-2);

% Plot handle
cmap = parula(4);
c1 = cmap(1,:);
c2 = cmap(3,:);
lw = 4;
fsize = 14;

figure(7)
hold on
for(i = 1:max(size(veckF)))
    i
    % run lamprey simulations
    % Change parameter values here
    p = set_params();
    p.kF = veckF(i);
    p.Ks = 0.1;
    p.ep = 0.1;
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

    % Run simulation
    [t,y] = ode45(@(t,y) lamprey_mod(t,y,params,...
        I1, I2),...
        tspan, IC, opts_ode);
    T = y(:,6);
    %[maxT, id] = max(T);
    TSS_lamprey(i) = T(end);
    [maxT, id] = max(T);
    Tmax_lamprey(i) = maxT;
    tTSS_lamprey(i) = t(id);

    if(i == 1)
        subplot(2,2,1)
        plot(t,y(:,6),'linewidth',lw,'color',cmap(i,:))
        xlabel('Time')
        ylabel('Thrombin')
        title('Lamprey')
        set(gca, 'fontsize', fsize)
        hold on
    else
        subplot(2,2,3)
        plot(t,y(:,6),'linewidth',lw,'color',cmap(i,:))
        xlabel('Time')
        ylabel('Thrombin')
        title('Lamprey')
        set(gca, 'fontsize', fsize)
        hold on
    end

    % run mammal simulations
    % Set parameters
    p = set_params_mammal();
    p.kF = veckF(i);
    p.Ks = 0.1;
    p.ep = 0.1;
    % Change parameter values here

    [params, parnames] = pars2vector(p,0);

    % Set initial conditions
    V0  = 1; 0.1;
    Va0 = 0;
    X0  = 10; 1;
    Xa0 = 0;
    P0  = 100; 10;
    T0  = 0;
    VIII0 = 0.01; 0.5;
    VIIIa0 = 0;
    IX0    = 1; 1;
    IXa0   = 0;
    IC = [V0; Va0; X0; Xa0; P0; T0; VIII0; VIIIa0; IX0; IXa0];

    % inhibitors
    I1 = 10;
    I2 = 10;

    % Run simulation
    [t,y] = ode45(@(t,y) mammal_mod(t,y,params,...
        I1, I2),...
        tspan, IC, opts_ode);

    T = y(:,6);
    TSS_mammal(i) = T(end);
    [maxT, id] = max(T);
    Tmax_mammal(i) = maxT;
    tTSS_mammal(i) = t(id);

    if(i == 1)
        subplot(2,2,2)
        plot(t,y(:,6),'linewidth',lw,'color',cmap(i,:))
        xlabel('Time')
        ylabel('Thrombin')
        title('Mammal')
        set(gca, 'fontsize', fsize)
        hold on
    else
        subplot(2,2,4)
        plot(t,y(:,6),'linewidth',lw,'color',cmap(i,:))
        xlabel('Time')
        ylabel('Thrombin')
        title('Mammal')
        set(gca, 'fontsize', fsize)
        hold on
    end

end