% clc
% clear all
% close all

%% sampling time

Ts = 0.1;
p = 75;
m = 2;

%% Nominal plant

A=[0 0 0 0;
    0 0 0 0;
    0 0 0 1;
    0 0 0 0];

B=[0 0.0005 0.0005;
    0 0.00005 0;
    0 0 0;
    0 0.000035 0];

C = [1   0   0   0;
    0   1   0   0;
    0   0   1   0];
D = zeros(3);

sys = ss(A,B,C,D,Ts)

%% Linear MPC

nx = 4;
ny = 3;
nu = 3;

mpcobj = mpc(sys,Ts,p,m);

x0 = zeros(size(sys.B));

% SolverOptions.Algorithm = 'sqp'

%% Weights

% mpcobj.Weights = struct('MV',[1, 1, 1],'Output',[1, 1, 1]);

mpcobj.Weights.OutputVariables = [500 100 100];
% mpcobj.Weights.ManipulatedVariables = [1, 0, 0];
% mpcobj.Weights.ManipulatedVariablesRate = [1, 1, 1];

%% Constrain inputs

mpcobj.MV(1).Min = -0.4;
mpcobj.MV(1).Max = 0.4;

mpcobj.MV(2).Min = 0;
mpcobj.MV(2).Max = 1000;

mpcobj.MV(3).Min = 0;
mpcobj.MV(3).Max = 1000;

%% Constrain outputs

% mpcobj.OV(1).Min = 0;
% mpcobj.OV(1).Max = 1;
% 
% mpcobj.OV(1).Min = 0;
% mpcobj.OV(1).Max = 1;
% 
% mpcobj.OV(1).Min = 0;
% mpcobj.OV(1).Max = 4000;

%% contraint softenning

mpcobj.Weights.ECR = 0.01;

%% Simulink

% Runtime = zeros(3,1);

open('MPC.slx')

tic
sim('MPC.slx')
Runtime(1) = toc;
