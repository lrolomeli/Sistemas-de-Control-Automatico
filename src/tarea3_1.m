%% Favor de ejecutar esta linea:
%% tarea3_1([0 10],[5 5 5],-1,-4)
function tarea3_1(tspan,x0, pdo, pdc)
global A B C L K F

close all;
clc;
% tspan = [0 10];
% pdo = -1;
% pdc = -4;
% x0 = [5 5 5];

C = [0 1 0];
B = [3;0;1];
A = [0 0 2; 2 1 -1; 0 0 2];

I = eye(3);

% Diseno del controlador
Mc = [B A*B (A^2)*B];
Hc = (A-pdc*I)*(A-pdc*I)*(A-pdc*I);
K = -[0 0 1]*(Mc^-1)*Hc;
rank(Mc); % El sistema es controlable
F = 1/(C*((-A-B*K)^-1)*B);

% Diseno del observador
Mo = [C;C*A;C*(A^2)];
rank(Mo);
%  El sistema solo es observable para la salida x2
Ho = (A-pdo*I)*(A-pdo*I)*(A-pdo*I);
L = -Ho*(Mo^-1)*[0;0;1];

[t,X] = ode45(@Tarea3_1_sys, tspan, [x0 0 0 0]);

figure;
subplot(3,1,1); plot(t,X(:,1),t,X(:,4),'--r'); title('Estado 1 y estimacion'); grid;
subplot(3,1,2); plot(t,X(:,2),t,X(:,5),'--r'); title('Estado 2 y estimacion'); grid;
subplot(3,1,3); plot(t,X(:,3),t,X(:,6),'--r'); title('Estado 3 y estimacion'); grid;

figure;
subplot(2,1,1); plot(t, X(:,1)-X(:,4)); title('Error de Observador X1'); grid;
subplot(2,1,2); plot(t, X(:,3)-X(:,6)); title('Error de Observador X3'); grid;
end

%% ODE
function dX = Tarea3_1_sys(t, X)

global A B C L K F

x = X(1:3);
xo = X(4:6);
x_ = [X(4); X(2); X(6)];

ref = 10;

% U = 0;
U = K*x_ + F*ref;

Y = C*x;
Ye = Y - C*xo;

dx = A*x + B*U;
dxo = A*xo + B*U - L*Ye;

dX = [dx; dxo];

end