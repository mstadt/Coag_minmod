xa = linspace(0,10,1000); 
va = linspace(0,200,1000); 

Km_Xa = 0.1; 

kT_10 = 0.1; 
s = 0; 


[xa_3d, va_3d] = meshgrid(linspace(0,100,1000), linspace(0,200, 1000)); 

%s = linspace(0,100,1000);

rate = kT_10*xa./(Km_Xa +xa) + ...
    s.*va./(s/2+va); 

s= 100; 
rate_3d =kT_10*xa_3d./(Km_Xa +xa_3d) + ...
    s.*va_3d./(s/2+va_3d).*xa_3d./(Km_Xa +xa_3d); 
figure(3)
plot(xa, rate,'linewidth',3); 
hold on; 
set(findall(gcf,'-property','FontSize'),'FontSize',36)
set(gcf,'color','w'); 
xlabel('xa')
ylabel('rate')

figure(8); 
surf(va_3d, xa_3d, rate_3d, rate_3d,'EdgeColor','none');  
hold on; 
set(findall(gcf,'-property','FontSize'),'FontSize',36)
set(gcf,'color','w'); 
xlabel('va')
ylabel('xa')
zlabel('rate')

figure(2)
contourf(xa_3d, va_3d, rate_3d) 
set(findall(gcf,'-property','FontSize'),'FontSize',36)
set(gcf,'color','w'); 

