clc;
% clear;


%% To Workspace

% T_s = 2;                  % sampleing rate
% num = size(out.FxF.Data); % number of samples

% inputs

Xref = out.Xref;
Yref = out.Yref;

Xref = squeeze(Xref);
Yref = squeeze(Yref);

plot(Yref,Xref,'-r')
title('Trajectory')
xlabel('X (m)')
ylabel('Y (m)')

% 
% % hold on
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

%%

figure(2)

% cost = out.cost;
% cost2 = out.cost;
% cost3 = out.cost;
cost4 = out.cost;


t = 0:0.1:20;

% plot(t,cost2,'-b')
% hold on
% plot(t,cost,'-r')
% hold on
% plot(t,cost3,'-k')
% hold on
plot(t,cost4)
title('Cost Funvtion Value','FontSize', 14)
xlabel('Time (s)','FontSize', 14)
ylabel('Cost Function','FontSize', 14)

legend('DNN Without Constraints','DNN With Constraints','GRU Without Constraints','GRU With Constraints')


%%

sys = out.sysout;

Xdot_s = sys(:,1);
ydot_s = sys(:,2);
psi_s = sys(:,3);

% ref = out.ref;
% 
% Xdot_r = ref(:,1);
% ydot_r = ref(:,2);
% psi_r = ref(:,3);

% sys1 = out.sysout;
% 
% Xdot_s1 = sys1(:,1);
% ydot_s1 = sys1(:,2);
% psi_s1 = sys1(:,3);


t = 0:0.01:20;

subplot(3,1,1);
% plot(t,Xdot_r,'-b')
% hold on
plot(t,Xdot_s,'-r')
% hold on
% plot(t,Xdot_s1,'-k')
title('Effect of Disturbance on Tracking Performance of Output Variables','FontSize', 14)
xlabel('Time (s)','FontSize', 14)
ylabel('Xdot (m/s)','FontSize', 14)
legend('Reference','Performance without disturbance','Performance with disturbance')

subplot(3,1,2);
% plot(t,ydot_r,'-b')
% hold on
plot(t,ydot_s,'-r')
hold on
% plot(t,ydot_s1,'-k')
xlabel('Time (s)','FontSize', 14)
ylabel('Ydot (m/s)','FontSize', 14)
legend('Reference','Performance without disturbance','Performance with disturbance')

subplot(3,1,3);
% plot(t,psi_r,'-b')
% hold on
plot(t,psi_s,'-r')
% hold on
% plot(t,psi_s1,'-k')
xlabel('Time (s)','FontSize', 14)
ylabel('Psi (rad)','FontSize', 14)
legend('Reference','Performance without disturbance','Performance with disturbance')
