%
% Thrombin metrics for varying flow
%   10/10/2024
%

veckF = 0:1:100;

Tmax_lamprey = zeros(size(veckF));
Tmax_mammal = zeros(size(veckF));

tThalf_lamprey = zeros(size(veckF));
tThalf_mammal = zeros(size(veckF));

tTmaxNoFlow_lamprey = zeros(size(veckF));
tTmaxNoFlow_mammal = zeros(size(veckF));

% set simulation time
t0 = 0;
tf = 300;
tspan = [t0,tf];
opts_ode = odeset('RelTol', 1e-6, 'AbsTol', 1e-9, 'MaxStep', 1e-2);

% Plot handle
cmap = parula(4);
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
    [maxT, id] = max(T);
    Tmax_lamprey(i) = maxT;
    if(i==1)
        tTmaxNoFlow_lamprey(i) = t(id);
    else
        idx = find(T<=Tmax_lamprey(1),1,'last');
        tTmaxNoFlow_lamprey(i) = t(idx);
    end
    id = find(T<=(0.5*maxT), 1,'last');
    tThalf_lamprey(i) = t(id);

    % run mammal simulations
    % Set parameters
    p = set_params_mammal();

    % Change parameter values here
    p.kF = veckF(i);
    p.Ks = 0.1;
    p.ep = 0.1;

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
    [maxT, id] = max(T);
    Tmax_mammal(i) = maxT;
    if(i==1)
        tTmaxNoFlow_mammal(i) = t(id);
    else
        idx = find(T<=Tmax_mammal(1), 1,'last');
        tTmaxNoFlow_mammal(i) = t(idx);
    end
    id = find(T<=0.5*maxT, 1,'last');
    tThalf_mammal(i) = t(id);
end


figure(8)
% Metric 1: time at max(T) no flow
subplot(2,2,1)
%plot(kF, (tTmaxNoFlow_lamprey-tTmaxNoFlow_lamprey(1))./tTmaxNoFlow_lamprey(1),...
%    'linewidth',lw,'color',cmap(1,:))
plot(veckF, tTmaxNoFlow_lamprey,'linewidth',lw,'color',cmap(2,:))
hold on
plot(veckF, tTmaxNoFlow_mammal,'linewidth',lw,'color',cmap(3,:))
xlabel('k_F')
ylabel('Time to reach no flow max[T]')
legend('Lamprey','Mammal')
set(gca, 'fontsize', fsize)

subplot(2,2,2)
plot(veckF, (Tmax_lamprey-Tmax_lamprey(1))./Tmax_lamprey(1),'linewidth',lw,'color',cmap(2,:))
hold on
plot(veckF, (Tmax_mammal-Tmax_mammal(1))./Tmax_mammal(1),'linewidth',lw,'color',cmap(3,:))
xlabel('k_F')
ylabel('Relative difference to no flow max[T]')
legend('Lamprey','Mammal')
set(gca, 'fontsize', fsize)

subplot(2,2,3)
plot(veckF, tThalf_lamprey,'linewidth',lw,'color',cmap(2,:))
hold on
plot(veckF, tThalf_mammal,'linewidth',lw,'color',cmap(3,:))
xlabel('k_F')
ylabel('Response time')
legend('Lamprey','Mammal')
set(gca, 'fontsize', fsize)

subplot(2,2,4)
plot(veckF, (Tmax_mammal-Tmax_lamprey)./Tmax_lamprey,'linewidth',lw,'color',cmap(1,:))
xlabel('k_F')
ylabel('Relative difference to max[T] in lamprey')
set(gca, 'fontsize', fsize)


% LOGLOG SCALE
figure(9)
% Metric 1: time at max(T) no flow
subplot(2,2,1)
%plot(kF, (tTmaxNoFlow_lamprey-tTmaxNoFlow_lamprey(1))./tTmaxNoFlow_lamprey(1),...
%    'linewidth',lw,'color',cmap(1,:))
loglog(veckF, tTmaxNoFlow_lamprey,'linewidth',lw,'color',cmap(2,:))
hold on
loglog(veckF, tTmaxNoFlow_mammal,'linewidth',lw,'color',cmap(3,:))
xlabel('k_F')
ylabel('Time to reach no flow max[T]')
legend('Lamprey','Mammal')
set(gca, 'fontsize', fsize)

subplot(2,2,2)
loglog(veckF, (Tmax_lamprey-Tmax_lamprey(1))./Tmax_lamprey(1),'linewidth',lw,'color',cmap(2,:))
hold on
loglog(veckF, (Tmax_mammal-Tmax_mammal(1))./Tmax_mammal(1),'linewidth',lw,'color',cmap(3,:))
xlabel('k_F')
ylabel('Relative difference to no flow max[T]')
legend('Lamprey','Mammal')
set(gca, 'fontsize', fsize)

subplot(2,2,3)
loglog(veckF, tThalf_lamprey,'linewidth',lw,'color',cmap(2,:))
hold on
loglog(veckF, tThalf_mammal,'linewidth',lw,'color',cmap(3,:))
xlabel('k_F')
ylabel('Response time')
legend('Lamprey','Mammal')
set(gca, 'fontsize', fsize)

subplot(2,2,4)
loglog(veckF, (Tmax_mammal-Tmax_lamprey)./Tmax_lamprey,'linewidth',lw,'color',cmap(1,:))
xlabel('k_F')
ylabel('Relative difference to max[T] in lamprey')
set(gca, 'fontsize', fsize)
