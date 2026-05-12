function dx = pendulum_dynamics(~,x,p,K)

X = x(1);
Xd = x(2);
th = x(3);
thd = x(4);
angle_offset = atan2(sin(th-pi), cos(th-pi));
state = [
    X;
    Xd;
    angle_offset;
    thd;
];
Vin  = -K*state;
Vin = max(min(Vin,24),-24);

didt = (Vin - p.R*i - p.Ke*omega_m) / p.L;
domega_m = (p.Kt*i - p.bm*omega_m) / p.Jm;
F = (p.Kt * i * p.Gr) / p.r;

A = [
    p.M + p.m,           p.m*p.l*cos(th);
    p.m*p.l*cos(th),     p.I + p.m*p.l^2
];

B = [
    F ...
    - p.bc*Xd ...
    + p.m*p.l*thd^2*sin(th);

    -p.m*p.g*p.l*sin(th) ...
    - p.bp*thd
];

acc = A\B;

Xdd = acc(1);
thdd = acc(2);

dx = [
    Xd;
    Xdd;
    thd;
    thdd;
    didt
];