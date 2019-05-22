%% ERROR_BLOQUES

function ERROR_BLOQUES
close all;
clc;
global A B C K2 K3
tspan = [0 10];
x0 = [0 0 0];
pd = -4;

% Matrices del sistema
A = [-1 -2 1; 0 -1 2; 0 -3 -2];
B = [0; 0; -2];
C = [0 1 0];

% Calculamos ganancias de control
K2 = pd; K3 = -10;

% Resuelve las ecuaciones diferenciales ordinarias (ODE's)
[t, X] = ode45(@ERROR_BLOQUES_sys, tspan, x0);

% Referencias y Derivadas
ref = -3*cos(2*t); 
dref = 6*sin(2*t); 
ddref = 12*cos(2*t);

% Senales de error
e2 = ref - X(2);
dx2 = -X(2) + 2*X(3);
de2 = dref - dx2;
x3ref = (K2*e2 - dref - X(2))/-2;
dx3ref = ( K2*de2 - ddref - dx2 )/-2;
e3 = x3ref - X(3);

% Ley de control
U = ( (K3*e3) - (dx3ref) - 3*X(2) - 2*X(3) )/2;

figure;
subplot(3,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(3,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(3,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;

figure; plot(t, C*X', 'r', t, ref); title('SALIDA'); grid;
figure; plot(t, U); title('SENAL DE CONTROL'); grid;

end

function dX = ERROR_BLOQUES_sys(t, X)

global A B C K2 K3

% Referencias y Derivadas
ref = -3*cos(2*t); 
dref = 6*sin(2*t); 
ddref = 12*cos(2*t);

% Senales de error
e2 = ref - X(2);
dx2 = -X(2) + 2*X(3);
de2 = dref - dx2;
x3ref = (K2*e2 - dref - X(2))/-2;
dx3ref = ( K2*de2 - ddref - dx2 )/-2;
e3 = x3ref - X(3);

% Ley de control
U = ( (K3*e3) - (dx3ref) - 3*X(2) - 2*X(3) )/2;
% ODE's

dX = A*X + B*U;

end