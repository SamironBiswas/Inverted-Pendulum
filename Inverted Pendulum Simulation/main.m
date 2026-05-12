clear
clc
params.M = 0.570;
params.m = 0.045;
params.l = 0.125;
params.I = 9.375e-4;
params.bc = 6.374;
params.bp = 2.223e-04;
params.g = 9.81;

params.L  = 5.5e-4;
params.R  = 7.0;
params.Ke = 0.0533;
params.Kt = 0.0533;
params.Jm = 1.03e-6;
params.Jl = 0.738;
params.bm = 1.461e-5;
params.bl = 2.223e-5;
params.JT = params.Jm+params.Jl;
params.bT = params.bm+params.bl;

params.r  = 0.0165;
params.Gr = 0.6;
params.Ku = (params.Kt)/(params.R*params.r*params.Gr);
solution;
x0          =    0;
xdot0       =    0;
theta0      =    pi-0.1;
thetadot0   =    0;
Vin = 0;
simOut = sim("SystemDynamics");
logs = simOut.logsout;
x = logs.get("Cart_position").Values;
theta = logs.get("Pendulum_angle").Values;
Vin_log = logs.get("Vin_log").Values;
figure;
plot(theta);
ylabel('Pendulum angle')
xlabel('Time')