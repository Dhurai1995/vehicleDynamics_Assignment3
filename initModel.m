%% Some clean up
clc; clear all;

%% Manoeuvre specifications

tStart      = 1;
strAmpSWD   = 30;
dwell       = 0.5;
strFreq     = 0.7;              % This frequency is from the NHTSA ESC test specifications. 

strAmpSS    = 10;
strMaxFreq  = 20;

%% %%% Test case definiton %%%%%%%%%%%%%%%%%%%%%%%%%%
u0          = 100/3.6;          % Longitudinal Speed [m/s]

%% %%%% Simulation parameters %%%%%%%%%%%%%%%%%%%%%%%
sampleTime  = 0.01;             % Simulation Step Size [s]
%simTime     = 10;               % Simulation end time [s]       <====== Use this for sine with dwell
simTime     = 100;              % Simulation end time [s]       <====== Use this for sine sweep

%% %%% Car parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m       = 1915;                 % Mass [kg]
Izz     = 2617;                 % Moment of inertia about z axis [kgm^2]
L       = 2.675;                % Wheelbase [m]
dist    = 0.39;                 % Rear weight distribution [-]
l1      = dist*L;               % Distance from COG to front axle [m]
l2      = L-l1;                 % Distance from COG to rear axle [m]
w       = 1.6;                  % Track width [m]
ms      = m-4e2;                % Sprung mass [kg]
Ixx     = 1e3;                  % Vehicle inertia about X axis
cPhi    = 6e4;                  % Vehicle total roll stiffness
kPhi    = 5e3;                  % Vehicle total roll damping
cLambda = 5.5e-1;               % Vehcile roll stiffness distribution
kLambda = 5.7e-1;               % Vehicle roll damping distribution
nst     = 15.9;                 % Steering ratio
h       = 0.543;                % Height of CoG
h1      = 0.045;                % Front roll center height
h2      = 0.101;                % Rear roll center height
h0      = h-(l1*h2+l2*h1)/L;    % Height of CoG above roll axis
g       = 9.81;                 % Acceleration due to gravity
uESCLim = 15/3.6;               % Minimum speed for ESC to function
rErrLim = 3e-1;                 % Yaw rate error threshold for ESC
escK    = 1875;                 % Yaw rate gain for ESC
C       = 1.5;                  % Magic formula parameter
E       = -1;                   % Magic formula parameter
mu0     = 1;                    % Road tyre friction coefficient
mu1     = 6e-5;                 % Tyre load based non-linearity parameter for friction
c0      = 21.3/2;               % Tyre stiffness parameter
c1      = 1.11e-4;              % Tyre load based non-linearity parameter for stiffness
Fz0     = 4000;                 % Rated load for the tyres
%
disp('Vehicle data loaded');