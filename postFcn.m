% Postprocessing after the simulation. Generates plots of the relevant
% vehicle states and parameters. 

% x - [LongVel LatVel YawVel LongAcc LatAcc YawAcc]

% Some figure formatting
set(0,'DefaultAxesFontSize',12)
set(0,'DefaultAxesLineWidth',1)
set(0,'defaultlinelinewidth',1)
% 
u = x(:,1);
v = x(:,2);
r = x(:,3);
ax = x(:,4);
ay = x(:,5);
rDot = x(:,6);

% % %% Longitudinal velocity
% % figure;
% % plot(t,u*3.6)
% % grid on;
% % xlabel('Time [s]')
% % ylabel('Longitudinal velocity [km/h]')
% % 
% % %% Lateral velocity
% % % figure('Name','Lateral velocity');
% % % plot(t,v*3.6)
% % % grid on;
% % % xlabel('Time [s]')
% % % ylabel('Lateral velocity [km/h]')
% % 
%% Yaw rate
figure('Name','Yaw rate and steer angle');
plot(t,r*180/pi,t,deltaf*nst*180/pi/2)
hold on;
% Try to add markers on the plot representing the ESC test requirements
% (Yaw rate requirements)
grid on;
ylabel('Yaw rate [deg/s]')
legend('Yaw rate','Str angle (scaled)')
xlabel('Time [s]')
drawnow;

%% Vehicle travel animation
figure;
hTrajectory = plot(X(1),Y(1),'b--');
hTitle=title(sprintf('Time = %0.3g',t(1)));
axis equal;
xlim([min(X)-10 max(X)+10])
ylim([min(Y)-10 max(Y)+10])
axis manual;
grid on;
hold on;
% Try to add markers on the plot representing the ESC test requirements
% (Lateral stability requirements)
xlabel('X [m]')
ylabel('Y [m]')

l1t = l1*5;
l2t = l2*5;
wt = w*5;

X1 =  l1t*cos(psi) - wt/2*sin(psi);
X2 =  l1t*cos(psi) + wt/2*sin(psi);
X3 =  l2t*cos(psi) + wt/2*sin(psi);
X4 =  l2t*cos(psi) - wt/2*sin(psi);

Y1 =  wt/2*cos(psi) + l1t*sin(psi);
Y2 = -wt/2*cos(psi) + l1t*sin(psi);
Y3 = -wt/2*cos(psi) + l2t*sin(psi);
Y4 =  wt/2*cos(psi) + l2t*sin(psi);

hCar = patch([X1(1) X2(1) X3(1) X4(1)], [Y1(1) Y2(1) Y3(1) Y4(1)],'red','facecolor','none','edgecolor','red');

xLimits = get(gca,'xlim');
yLimits = get(gca,'ylim');
axis manual;
xlim(xLimits)
ylim(yLimits)

for i = 1:1/(sampleTime*100):length(psi)
    set(hTrajectory,'XData',X(1:i),'YData',Y(1:i))
    set(hCar,'Xdata',X(i)+[X1(i) X2(i) X3(i) X4(i)], 'Ydata',Y(i)+[Y1(i) Y2(i) Y3(i) Y4(i)]);
    set(hTitle,'String',sprintf('Time= %0.3g',t(i)));
    drawnow;
    
end

%% Vehicle path and orientation
figure('Name','Vehicle path');
plot(X,Y,'b--')
axis equal;
grid on;
hold on;
% Try to add markers on the plot representing the ESC test requirements
% (Lateral stability requirements)
xlabel('X [m]')
ylabel('Y [m]')

for i = 1:1/(sampleTime):length(psi)
    patch(X(i)+[X1(i) X2(i) X3(i) X4(i)], Y(i)+[Y1(i) Y2(i) Y3(i) Y4(i)],'red','facecolor','none','edgecolor','red');
end
drawnow;

% %% Vehicle lateral acceleration
% figure;
% plot(t,ay)
% grid on;
% xlabel('Time [s]')
% ylabel('Lateral acceleration [m/s^2]')
% 
% %% Vehicle longitudinal acceleration
% % figure;
% % plot(t,ax)
% % grid on;
% % xlabel('Time [s]')
% % ylabel('Longitudinal acceleration [m/s^2]')
% 
% %% Normal load on the wheels
% % figure;
% % plot(t,Fz)
% % grid on;
% % xlabel('Time [s]')
% % ylabel('Wheel normal loads [N]')
% % legend('Front left','Front right','Rear left','Rear right')