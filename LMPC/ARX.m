clc
% clear all


%% Loading data

% load data

X = readtable('C:\Users\Arash\OneDrive\Desktop\1st Term\MLC for Engineering Applications\Projects\Codes\LMPC\train_features_narx_3step.csv');
Y = readtable('C:\Users\Arash\OneDrive\Desktop\1st Term\MLC for Engineering Applications\Projects\Codes\LMPC\train_targets_narx_3step.csv');

X = table2array(X);
Y = table2array(Y);

X = X(:,2:end);
Y = Y(:,2:end);

WxA = X(:,1); 
FxF = X(:,2);
FxR = X(:,3);

Xdot = Y(:,1);
Ydot = Y(:,2);
psi = Y(:,3);

% psi = psi1;


%% 

% y1 = (Xdot-min(Xdot))/(max(Xdot)-min(Xdot));
% y2 = (Ydot-min(Ydot))/(max(Ydot)-min(Ydot));
% y3 = (psi-min(psi))/(max(psi)-min(psi));
% 
% u1 = (WxA-min(WxA))/(max(WxA)-min(WxA));
% u2 = (FxF-min(FxF))/(max(FxF)-min(FxF));
% u3 = (FxR-min(FxR))/(max(FxR)-min(FxR));

% y1 = (Xdot)/(max(Xdot));
% y2 = (Ydot)/(max(Ydot));
% y3 = (psi)/(max(psi));
% 
% u1 = (WxA)/(max(WxA));
% u2 = (FxF)/(max(FxF));
% u3 = (FxR)/(max(FxR));

y1 = (Xdot);
y2 = (Ydot);
y3 = (psi);

u1 = (WxA);
u2 = (FxF);
u3 = (FxR);

sample_time = 0.1;

Z = iddata([y1,y2,y3],[u1, u2, u3],sample_time,'Tstart',0);
t = Z.SamplingInstants;

figure(1)

subplot(3,2,1)
plot(t,Z.u(:,1)), ylabel('WxA [rad]') 
title('Logged Input )Data')

subplot(3,2,3)
plot(t,Z.u(:,2)), ylabel('FxF [N]')

subplot(3,2,5)
plot(t,Z.u(:,3)), ylabel('FxR [N]')
xlabel('Time (s)')


subplot(3,2,2)
plot(t,Z.y(:,1)), ylabel('Xdot [m/s]') 
title('Logged Output Data')

subplot(3,2,4)
plot(t,Z.y(:,2)), ylabel('Ydot [m/s]') 

subplot(3,2,6)
plot(t,Z.y(:,3)), ylabel('Psi [rad]') 
xlabel('Time (s)')

%% 

na = ones(3,3);
nb = ones(3,3);
nk = zeros(3,3);

sys = arx(Z,[na nb nk]);

%%
% A = -[sys.A(2)];
% B = [sys.B{1, 1} sys.B{1, 2} sys.B{1, 3}];

A1 = cell2mat(sys.A);
A = [A1(:,2) A1(:, 4) A1(:, 6)];
B = cell2mat(sys.B);

  %%
  
  xk = [y1(1); y2(1); y3(1)];
  uk = [u1(1); u2(1);u3(1)];
  k = 1;

  for i = 1:size(Xdot,1)
      
      uk = [u1(k); u2(k);u3(k)];
      xk1 = A*xk + B*uk;
      
      % Xdot_hat(i) = ones(1,3)*xk1 + ones(1,3)*uk;
      % Ydot_hat(i) = ones(1,3)*xk1 + ones(1,3)*uk;
      % psi_hat(i) = ones(1,3)*xk1 + ones(1,3)*uk;

      % 
      Xdot_hat(i) = ones(1,3)*xk1;
      Ydot_hat(i) = ones(1,3)*xk1;
      psi_hat(i) = ones(1,3)*xk1;

      xk = xk1;
      k = k+1;
  end
  
%% Plotting

figure(2)

subplot(3,2,1)
plot(t,Z.u(:,1)), ylabel('WxA [rad]')
title('Logged Input Data')

subplot(3,2,3)
plot(t,Z.u(:,2)), ylabel('FxF [N]')

subplot(3,2,5)
plot(t,Z.u(:,3)), ylabel('FxR [N]')
xlabel('Time (s)')


subplot(3,2,2)
plot(t,Z.y(:,1)), ylabel('Xdot [m/s]') 
title('Logged Output Data')
hold on
plot(t,Xdot_hat,'r--')

subplot(3,2,4)
plot(t,Z.y(:,2)), ylabel('Ydot [m/s]') 
hold on
plot(t,Ydot_hat,'r--')

subplot(3,2,6)
plot(t,Z.y(:,3)), ylabel('Psi [rad]') 
xlabel('Time (s)')
hold on
plot(t,psi_hat,'r--')
