function tarea3_2_reduc
global A B C L K F Ap H Ko

close all;
clc;
tspan = [0 10];
pdo = -5;
pdc = -4;
x0 = [5 5 5];

C_orig = [1 0 0; 0 1 0];
C = C_orig(1,:);
B = [4;1;4];
A = [   -3 -1 -4    ; 
        -2 -4  2    ; 
         1 -1  1   ];
I = eye(2);

A11 = A(1,1);
A12 = A(1,2:3);
A21 = A(2:3,1);
A22 = A(2:3,2:3);

B1 = B(1,1);
B2 = B(2:3,1);

Co = A12;
Ao = A22;

% Diseno del observador
Mo = [Co; Co*Ao];
rank(Mo);

%  El sistema solo es observable para la salida x2
Ho = (Ao-pdo*I)*(Ao-pdo*I);
Ko = Ho*(Mo^-1)*[0;1];

Ap = A22 - Ko*A12;
L = A21 - Ko*A11 + Ap*Ko;
H = B2 - Ko*B1;

% Diseno del controlador
Mc = [B A*B (A^2)*B];
Hc = (A-pdc*eye(3))*(A-pdc*eye(3))*(A-pdc*eye(3));
K = -[0 0 1]*(Mc^-1)*Hc;
rank(Mc); % El sistema es controlable
F = 1/(C*((-A-B*K)^-1)*B);

[t,X] = ode45(@Tarea3_2_reduc_sys, tspan, [x0 0 0]);

xo = X(:,1)*Ko' + X(:,4:5);

figure;
subplot(3,1,1); plot(t,X(:,1));                title('Estado 1 y estimacion'); grid;
subplot(3,1,2); plot(t,X(:,2),t,xo(:,1),'--r'); title('Estado 2 y estimacion'); grid;
subplot(3,1,3); plot(t,X(:,3),t,xo(:,2),'--r'); title('Estado 3 y estimacion'); grid;

figure;
subplot(2,1,1); plot(t, xo(:,1)-X(:,2)); title('Error de Observador X1'); grid;
subplot(2,1,2); plot(t, xo(:,2)-X(:,3)); title('Error de Observador X3'); grid;
end

%% ODE
function dX = Tarea3_2_reduc_sys(t, X)

global A B C L K F Ap H Ko

% x = X(1:3);
% xo = X(4:6);
% x_ = [X(4); X(2); X(6)];
x = X(1:3);
z = X(4:5);

ref = 10;

Y = C*x;
xo = [X(1); z + Ko*Y];

% U = 0;
U = K*xo + F*ref;

dx = A*x + B*U;
dz = Ap*z + L*Y + H*U;

dX = [dx; dz];

end