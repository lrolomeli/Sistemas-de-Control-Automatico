function tarea2_2_plot(tspan, x0, K)

global A B C k1 k2

k1 = K(1); k2 = K(2);

% Matrices del sistema
A = [1 -4 0; 2 -2 1; -3 1 -2];
B = [0; 1; 0];
C = [1 0 0];

% Resuelve las ecuaciones diferenciales ordinarias (ODE's)
[t, X] = ode45(@tarea2_2_sys, tspan, x0);

ref = 3 - exp(-t/2);

figure;
subplot(3,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(3,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(3,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;

Y = X*C';

figure; plot(t, Y, t, ref, 'blue'); title('SALIDA Y REFERENCIA');

end


function dX = tarea2_2_sys(t, X)

global A B C k1 k2

x1 = X(1); x2 = X(2); x3 = X(3);

dx1 = A(1,:)*X; 
% dx2 = A(2,:)*X;

ref = 3 - exp(-t/2);
dref = (1/2) * exp(-t/2);
ddref = (-1/4) * exp(-t/2);

e1 = ref - C*X; % Sera esto lo mismo que e1 = ref - x1; al parecer si.
de1 = dref - dx1;

x2ref = (k1*e1 - dref + x1)/4;
e2 = x2ref - x2;
dx2ref = (k1*de1 - ddref + dx1)/4;
% de2 = dx2ref - dx2;

U = dx2ref - 2*x1 + 2*x2 - x3 - k2*e2;

dX = A*X + B*U;

end

% Calling function tarea2_2_plot
% tarea2_2_plot([0 5], [0 0 0], [-5 -5])