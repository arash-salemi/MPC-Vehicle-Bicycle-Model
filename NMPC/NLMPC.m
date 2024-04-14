clc
% clear all
% close all


% global network1
% 
% network1 = load('C:\Users\Arash\OneDrive\Desktop\1st Term\MLC for Engineering Applications\Projects\Phase 3\NMPC\trained_net.mat');
% network1 = network1.trained_net;

% % Analyze the network and get its equations
% analyzeResult = analyzeNetwork(network1);
% equations = analyzeResult.Equations

%% Nonlinear MPC

nx = 4;
ny = 3;
nu = 3;

nlobj = nlmpc(nx,ny,nu);

%% sampling time

Ts = 0.1;
p = 20;
m = 3;

%% Weights

nlobj.Weights.OutputVariables = [50 50 50];
% nlobj.Weights.ManipulatedVariables = [1, 0, 0];
% nlobj.Weights.ManipulatedVariablesRate = [1, 1, 1];

%% Sover options 

nlobj.Optimization.SolverOptions.Display = 'iter';
nlobj.Optimization.SolverOptions.OptimalityTolerance = 1e-10;
nlobj.Optimization.SolverOptions.StepTolerance = 1e-10;
nlobj.Optimization.SolverOptions.Algorithm = 'sqp';
nlobj.Optimization.SolverOptions.SpecifyObjectiveGradient = true;
nlobj.Optimization.SolverOptions.SpecifyConstraintGradient = true;
nlobj.Optimization.SolverOptions.MaxIterations = 5000;

%% horizon.

nlobj.Ts = Ts;
nlobj.PredictionHorizon = p; 
nlobj.ControlHorizon = m;

%% Constrain Normalaized inputs

% nlobj.MV(1).Min = -0.4;
% nlobj.MV(1).Max = 0.4;
% 
% nlobj.MV(2).Min = -250;
% nlobj.MV(2).Max = 500;
% 
% nlobj.MV(3).Min = -250;
% nlobj.MV(3).Max = 500;

nlobj.MV(1).Min = -0.4;
nlobj.MV(1).Max = 0.4;

nlobj.MV(2).Min = -2500;
nlobj.MV(2).Max = 5000;

nlobj.MV(3).Min = -2500;
nlobj.MV(3).Max = 5000;

%% Constrain outputs

mpcobj.OV(2).Min = -10;
mpcobj.OV(2).Max = 50;

mpcobj.OV(2).Min = -1;
mpcobj.OV(2).Max = 1;

%% contraint softenning

nlobj.Weights.ECR = 0.001;

%% StateFcn

% nlobj.Model.StateFcn = 'MyLSTMstateFnc';
nlobj.Model.StateFcn = 'Model_ANN';

nlobj.Model.IsContinuousTime = false;

nlobj.Model.OutputFcn = @(x,u) [x(1); x(2); x(3)];

%% validation

x0 = zeros(4,1);
u0 = zeros(3,1);

validateFcns(nlobj,x0,u0)

%% Simulink

open('Load_NLMPC_ANN.slx')

tic
sim('Load_NLMPC_ANN.slx')
Runtime(3) = toc;

%% 

% x = [1 2 3];
% 
% M = mean(Runtime);
% S = std(Runtime)
%
% figure (3)
% errorbar(1,M(1),S(1),'x')
% hold on
% errorbar(2,M(2),S(2),'x')
% hold on
% errorbar(3,M(3),S(3),'x')
% title('Comparison of MPC Controllers Runtimes')
% xlabel('MPC type');
% ylabel('Runtime (Seconds)');
% xlim([0.9 3.1])
% legend('Linear MPC','Nonlinear MPC with DNN','Nonlinear MPC with GRU')
