%% Effects of varying TF:VIIa in mammal and lamprey.



TF7a = logspace(-3, 2, 6);
results = zeros(length(TF7a), 3);
thrombin = zeros(length(TF7a), 101);

% Generate colors for plotting
colors = parula(length(TF7a) + 2);

kflow = 1;

figure(1)
for ii = 1:length(TF7a)
    [time, thrombin] = lamprey_pscan(kflow, TF7a(ii));
    [tresponse, Thrhm, maxT] = metrics(time, thrombin);
    plot(time, thrombin, 'DisplayName', num2str(TF7a(ii)), 'LineWidth',2, ...
        'Color', colors(ii, :))
    title(strcat('Lamprey TF:VIIa Varying'))
    xlabel('Time')
    ylabel('Thrombin')
    hold on
    xline(tresponse,  'DisplayName', '','LineStyle','--', ...
         'Color', colors(ii, :), 'HandleVisibility','off') 
    yline(Thrhm,  'DisplayName', '','LineStyle','--', ...
         'Color', colors(ii, :), 'HandleVisibility','off') 
    %ylim([0, 0.015])
    xlim([0, 500])
    %yscale('log')
end
hold off 
colormap("parula")
lg = legend;
title(lg, 'TF:VIIa Concentration');
exportgraphics(gcf, 'Lamprey_TFVIIa_zeroflow.png',  'Resolution', 300);


figure(2)
for ii = 1:length(TF7a)
    [time, thrombin] = mammal_pscan(kflow, TF7a(ii));
    [tresponse, Thrhm, maxT] = metrics(time, thrombin);
    plot(time, thrombin, 'DisplayName', num2str(TF7a(ii)), 'LineWidth',2, ...
        'Color', colors(ii, :))
    title(strcat('Mammal TF:VIIa Varying'))
    xlabel('Time')
    ylabel('Thrombin')
    hold on
    xline(tresponse,  'DisplayName', '','LineStyle','--', ...
         'Color', colors(ii, :), 'HandleVisibility','off') 
    yline(Thrhm,  'DisplayName', '','LineStyle','--', ...
         'Color', colors(ii, :), 'HandleVisibility','off') 
    %ylim([0, 0.015])
    xlim([0, 500])
    %yscale('log')
end
hold off 
colormap("parula")
lg = legend;
title(lg, 'TF:VIIa Concentration');
exportgraphics(gcf, 'Mammal_TFVIIa_zeroflow.png',  'Resolution', 300);


% 
% %% Plot results
% % fig specs
% cmap = summer(4);
% c1 = cmap(1,:);
% c2 = cmap(3,:);
% lw = 4;
% fsize = 14;
% xlab = 't';
% 
% figure(2);
% clf;
% nr = 5; nc = 2;
% tiledlayout(nr,nc);
% set(gcf,'Position',[440    76   922   721])
% 
% % factor V
% nexttile;
% plot(t,y(:,1), 'linewidth', lw, 'color', c1)
% xlabel(xlab)
% xlim(tspan)
% ylabel('Factor V')
% grid on
% set(gca,'fontsize',fsize)
% 
% % factor Va
% nexttile;
% plot(t,y(:,2),'linewidth',lw,'color',c1)
% xlabel(xlab)
% xlim(tspan)
% ylabel('Factor Va')
% grid on
% set(gca, 'fontsize', fsize)
% 
% % factor X
% nexttile;
% plot(t,y(:,3),'linewidth',lw,'color',c1)
% xlabel(xlab)
% xlim(tspan)
% ylabel('Factor X')
% grid on
% set(gca, 'fontsize', fsize)
% 
% % factor Xa
% nexttile;
% plot(t,y(:,4),'linewidth',lw,'color',c1)
% xlabel(xlab)
% xlim(tspan)
% ylabel('Factor Xa')
% grid on
% set(gca, 'fontsize', fsize)
% 
% % Factor VIII
% nexttile;
% plot(t,y(:,7),'linewidth',lw,'color',c1)
% xlabel(xlab)
% xlim(tspan)
% ylabel('Factor VIII')
% grid on
% set(gca, 'fontsize', fsize)
% 
% 
% % Factor VIII
% nexttile;
% plot(t,y(:,8),'linewidth',lw,'color',c1)
% xlabel(xlab)
% xlim(tspan)
% ylabel('Factor VIIIa')
% grid on
% set(gca, 'fontsize', fsize)
% 
% % Factor IX
% nexttile;
% plot(t,y(:,9),'linewidth',lw,'color',c1)
% xlabel(xlab)
% xlim(tspan)
% ylabel('Factor IX')
% grid on
% set(gca, 'fontsize', fsize)
% 
% 
% % Factor IXa
% nexttile;
% plot(t,y(:,10),'linewidth',lw,'color',c1)
% xlabel(xlab)
% xlim(tspan)
% ylabel('Factor IXa')
% grid on
% set(gca, 'fontsize', fsize)
% 
% % Prothrombin
% nexttile;
% plot(t,y(:,5),'linewidth',lw,'color',c2)
% xlabel(xlab)
% xlim(tspan)
% ylabel('Prothrombin')
% grid on
% set(gca, 'fontsize', fsize)
% 
% % Thrombin
% nexttile;
% plot(t,y(:,6),'linewidth',lw,'color',c2)
% xlabel(xlab)
% xlim(tspan)
% ylabel('Thrombin')
% grid on
% set(gca, 'fontsize', fsize)
% 
% 
% 
