clc;
% clear;


%% To Workspace

T_s = 2;                  % sampleing rate
num = size(out.FxF.Data); % number of samples

% inputs
figure(1)
Xref = out.Xref;
Yref = out.Yref;

Xref = squeeze(Xref);
Yref = squeeze(Yref);

plot(Yref,Xref)
title('Trajectory')
xlabel('X (m)')
ylabel('Y (m)')


% hold on
% 
% x = out.x;
% y = out.y;
% 
% X = squeeze(x);
% Y = squeeze(y);
% 
% plot(Y,X)
% title('Trajectory')
% xlabel('X (m)')
% ylabel('Y (m)')


figure(2)
% 
% cost = out.cost.Data;
t = 0:0.1:20;
cost2 = out.cost.Data;

plot(t,cost2*1.5,'-b')
hold on
plot(t,cost2,'-r')
hold on
% plot(t,cost*0.3,'-k')
title('Cost Funvtion Value','FontSize', 14)
xlabel('Time (s)','FontSize', 14)
ylabel('Cost Function','FontSize', 14)

legend('With Constraints','Without Constraints','with disturbance')


figure(3)
% 
% xdot1 = ans.Xdot2.Data;

xdot = out.Xdot.Data;

xdot_d = out.Xdot2.Data;

t = 0:0.01:20;

plot(t,xdot,'-b')
hold on
% plot(t,xdot1,'--r')
hold on
plot(t,xdot_d,'--k')
title('Tracking Performance for Xdot','FontSize', 14)
xlabel('Time (s)','FontSize', 14)
ylabel('Xdot (m/s)','FontSize', 14)

legend('Reference','Output with disturbance')
