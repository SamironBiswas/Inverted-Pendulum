syms M m l I bc bp g
syms R L Ke Kt Jm bm
syms r Gr F
syms x xd th thd i omega_m
syms xdd thdd

Vt = (Kt*i*Gr)/r;
Ku = (Kt*Gr)/(R*r);
eq1 = (M+m)*xdd - m*l*thdd + bc*xd == F;
eq2 = (I + m*l^2)*thdd - m*g*l*th == m*l*xdd - bp*thd;
sol = solve([eq1 eq2],[xdd thdd]);
f = [
    xd;
    sol.xdd;
    thd;
    sol.thdd;
];
states = [x; xd; th; thd];

A = jacobian(f, states);
B = jacobian(f, F);
A_num = subs(A,...
[M m l I bc bp g R L Ke Kt Jm bm r Gr],...
[0.570 0.045 0.125 9.375e-4 6.374 2.223e-4 9.81 ...
 7.0 5.5e-4 0.0533 0.0533 1.03e-6 1.461e-5 ...
 0.0165 0.6]);

B_num = subs(B,...
[M m l I bc bp g R L Ke Kt Jm bm r Gr],...
[0.570 0.045 0.125 9.375e-4 6.374 2.223e-4 9.81 ...
 7.0 5.5e-4 0.0533 0.0533 1.03e-6 1.461e-5 ...
 0.0165 0.6]);

A_num = double(A_num);
B_num = double(B_num);
C = eye(4);
D = zeros(4,1);

sys = ss(A_num,B_num,C,D);
Q = diag([10 1 100 1]);
R = 0.1;

K = lqr(A_num,B_num,Q,R);
Acl = A_num - B_num*K;