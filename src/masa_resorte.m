function masa_resorte(tspan, x0, K)

global A B C k1 k2 k3

k1 = K(1); k2 = K(2); k3 = K(3);

A = [0 1 0; -0.0923 -0.1077 0.1538; 0 -20 -20000];
B = [0; 0; 1000];
C = [1 0 0];

% Resuelve las ecuaciones diferenciales ordinarias (ODE's)
[t, X] = ode45(@masa_resorte_sys, tspan, x0);

% Referencias y Derivadas
ref = -2 + (1/2)*cos(2*t);

figure;
subplot(3,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(3,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(3,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;

Y = X*C';

figure; plot(t, Y, t, ref, 'red')
end

function dX = masa_resorte_sys(t, X)

global A B C k1 k2 k3

x1 = X(1);
x2 = X(2);
x3 = X(3);

dx1 = A(1,:)*X;
dx2 = A(2,:)*X;

r = 1;

ref = -2 + (1/2)*cos(2*t);
dref = -sin(2*t);
ddref = -2*cos(2*t);
dddref = 4*sin(2*t);

e1 = ref - r*x1;
x2ref = dref - k1*e1;

% tambien x2 = dx1 = A(1:,)*X;
dx2ref = ddref - k1*(dref - dx1);
ddx2ref = dddref - k1*(ddref - dx2);

e2 = x2ref - x2;

x3ref = (dx2ref + 0.0923*x1 + 0.1077*x2 - k2*e2)/0.1538;
dx3ref = (ddx2ref + 0.0923*dx1 + 0.1077*dx2 - k2*(dx2ref - dx2))/0.1538;

e3 = x3ref-x3;

U = (dx3ref + 20*x2 + 20000*x3 - k3*e3)/1000;

dX = A*X + B*U;

end