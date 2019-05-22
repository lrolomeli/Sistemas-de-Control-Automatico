function Ejemplo_PID_plot(tspan, x0)

global A B C Kp Ki Kd

% Matrices del sistema
A = [0 1 0; 0 0 1; 16 -6 -9];
B = [0; 0; 1];
C = [1 0 0];

eigs(A)

Kp = 1458; Ki = 322; Kd = 1466;

[t, X] = ode45(@Ejemplo_PID_sys, tspan, [0 x0]);

ref = 1+0*t;
% ref = 2*sin(t);


% Grafica salida y referencia

figure;
plot(t, ref, 'r', t, X(:,2:4)*C'); 
title('Salida y Referencia');

end

function dX = Ejemplo_PID_sys(t, X)

global A B C Kp Ki Kd

ref = 1; %Entrada escalon unitario
dref = 0;

E = ref - C*X(2:4);
dE = dref - C*A*X(2:4);
iE = X(1);

U = Kp*E + Ki*iE + Kd*dE;

% ODE's

dX = [E; A*X(2:4) + B*U];

end