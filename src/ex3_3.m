%% Favor de ejecutar esta linea:
%% ex3_3
function ex3_3
global A B K F C L Ap H Ko

close all;
clc;
tspan = [0 5];
pdo = -4;
pdc = -3;
x0 = [2 2 2];

A = [-2 1 -3; -3 -1 -1; 1 0 -2];
B = [2;3;-3];
C = [0 1 0];
I3 = eye(3);

I2 = eye(2);

A11 = -1;
A12 = [-3 -1];
A21 = [1; 0];
A22 = [-2 -3; 1 -2];
B1 = 3;
B2 = [2;-3];

Co = A12;
Ao = A22;

% Diseno del observador
Mo = [Co; Co*Ao];
rank(Mo);


Ho = (Ao-pdo*I2)*(Ao-pdo*I2);
Ko = Ho*(Mo^-1)*[0;1];

Ap = A22 - Ko*A12;
L = A21 - Ko*A11 + Ap*Ko;
H = B2 - Ko*B1;

% Diseno del controlador
Mc = [B A*B (A^2)*B];
Hc = (A-pdc*I3)*(A-pdc*I3)*(A-pdc*I3);
K = -[0 0 1]*(Mc^-1)*Hc;
rank(Mc); % El sistema es controlable
F = 1/(C*((-A-B*K)^-1)*B);

[t,X] = ode45(@ex3_3_sys, tspan, [x0 0 0]);

xo = X(:,2)*Ko' + X(:,4:5);

figure;
subplot(3,1,2); plot(t,X(:,1),t,xo(:,1),'--r'); title('Estado 1 y estimacion'); grid;
subplot(3,1,1); plot(t,X(:,2));                 title('SALIDA'); grid;
subplot(3,1,3); plot(t,X(:,3),t,xo(:,2),'--r'); title('Estado 3 y estimacion'); grid;

figure;
subplot(2,1,1); plot(t, xo(:,1)-X(:,1)); title('Error de Observador X1'); grid;
subplot(2,1,2); plot(t, xo(:,2)-X(:,3)); title('Error de Observador X3'); grid;

end

%% ODE
function dX = ex3_3_sys(t, X)

global A B C L K F Ap H Ko

x = X(1:3);
z = X(4:5);

ref = 50;

Y = C*x;
xo = [X(2); z + Ko*X(2)];

U = K*xo + F*ref;

dx = A*x + B*U;
dz = Ap*z + L*Y + H*U;

dX = [dx; dz];

end