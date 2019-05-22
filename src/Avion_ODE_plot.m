function Avion_ODE_plot(tspan, x0, pd)
% Argumentos:
% x0 = Condiciones iniciales
% tspan = periodo de integracion

global A B C D K F

% Matrices del sistema 
A = [-0.313 56.7 0; -0.0139 -0.426 0; 0 56.7 0];
B = [0.232; 0.0203; 0];
C = [1 0 1];
D = 0;
I = eye(3);

% Calculamos ganancias de control
Mc = [B A*B (A^2)*B];
H = (A-pd(1)*I)*(A-pd(2)*I)*(A-pd(3)*I);
K = -[0 0 1]*(Mc^-1)*H;
F = 1/(C*((-A-B*K)^-1)*B);
eigs(A+B*K)

% Resuelve las ecuaciones diferenciales ordinarias (ODE's)
[t, X] = ode45(@Avion_ODE_sys, tspan, x0);

ref = 1.5;  
% ref = 1.5 * sin(t); % Que tal con referencias no constantes

U = K*X' + F*ref;

maxU = max(abs(U));

subplot(2,1,1);  plot(t, X*C', t, ref, 'red'); title('SALIDA Y REFERENCIA'); grid;
subplot(2,1,2);  plot(t, U); title('ENTRADA'); grid;

end