function diff_drive_car
close all;
clc;

% VARIABLES GLOBALES
global A B C Ke

% Tiempo de simulacion.
tspan = [0 10];
% Condiciones Iniciales en metros y radianes respectivamente.
x0 = [1 0];
% radio de la llanta medida en metros.
R = 0.0325;
% distancia entre llantas.
L = 0.130;

% Matrices del sistema.
A = 0;
B = [R/2 R/2; R/L -R/L];
C = [1 0; 0 1];

% Calculamos ganancias de control.
Ke = -4;

% Resuelve las ecuaciones diferenciales ordinarias.
[t, X] = ode45(@sys, tspan, x0);

% Referencias
ref = [sin(t) cos(t)];
dref = [cos(t) -sin(t)];

Y = X*C';
e = ref - Y;
size(e)

% velocidades angulares en rad/s de cada motor.
U = (C*B)^-1*(dref - X*(C*A)' - Ke*e)';

% Ley de control acotada
U(U>34) = 34;
U(U<-34) = -34;

% Graficas
figure; 
subplot(4,1,1); plot(t, Y(:,1), t, ref(:,1)', 'red'); xlabel('tiempo');ylabel('metros');
title('Distancia Y REFERENCIA'); grid;
subplot(4,1,2); plot(t, Y(:,2), t, ref(:,2)', 'red');xlabel('tiempo');ylabel('radianes');
title('Direccion Y REFERENCIA'); grid;
subplot(4,1,3); plot(t, e(:,1)); title('error Distancia'); grid;
subplot(4,1,4); plot(t, e(:,2)); title('error Direccion'); grid;

figure;
subplot(2,1,1); plot(t, U(1,:)); title('Motor izquierdo'); xlabel('tiempo');ylabel('rad/s'); grid;
subplot(2,1,2); plot(t, U(2,:)); title('Motor derecho'); xlabel('tiempo');ylabel('rad/s');grid;

end

function dX = sys(t, X)

global A B C Ke

% Referencias
ref = [sin(t); cos(t)];
dref = [cos(t); -sin(t)];

% Variable de Error
e = ref - C*X;

% Ley de Control

U = (C*B)^-1*(dref - C*A*X - Ke*e);

% Ley de control acotada
U(U>34) = 34;
U(U<-34) = -34;

%ODE's
dX = A*X + B*U;

end