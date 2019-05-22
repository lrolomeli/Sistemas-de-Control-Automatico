%% examen2([0 10], [0 0 0 0], [-6 -6 -2 -2])
% Los polos de la primer linea fueron los que utilice a pesar
% de que los polos calculados fueron examen2([0 10], [0 0 0 0], [-3 -3 -2.37 -2.37])

function examen2(tspan, x0, pd)
% Argumentos:
% x0 = Condiciones iniciales
% tspan = periodo de integracion

global A B C D K F

% Matrices del sistema 
A = [-3 -2 3 0; 2 -5 1 3; 1 2 -3 0; 3 -1 1 -5];
B = [2; -3; 0; 0];
C = [1 0 0 0];
D = 0;
I = eye(4);

% Calculamos ganancias de control
Mc = [B A*B (A^2)*B (A^3)*B];
H = (A-pd(1)*I)*(A-pd(2)*I)*(A-pd(3)*I)*(A-pd(4)*I);
K = -[0 0 0 1]*(Mc^-1)*H;
F = 1/(C*((-A-B*K)^-1)*B);
eigs(A+B*K)

% Resuelve las ecuaciones diferenciales ordinarias (ODE's)
[t, X] = ode45(@examen2_sys, tspan, x0);

ref = 10;  
% ref = 1.5 * sin(t); % Que tal con referencias no constantes

U = K*X' + F*ref;

maxU = max(abs(X*C'))

subplot(2,1,1);  plot(t, X*C', t, ref, 'red'); title('SALIDA Y REFERENCIA'); grid;
subplot(2,1,2);  plot(t, U); title('ENTRADA'); grid;

end

function dX = examen2_sys(t, X)

global A B C D K F

ref = 10;  

U = K*X + F*ref;

% ODE's
dX = A*X + B*U;

end