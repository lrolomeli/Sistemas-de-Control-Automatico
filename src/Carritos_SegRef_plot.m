function Carritos_SegRef_plot(tspan, x0, pd)

global A B C K F

% Parametros del sistema
k1 = 150; k2 = 700; b1 = 15; b2 = 30; M1 = 5; M2 = 20;

% Matrices del sistema
A = [0 0 1 0; 0 0 0 1; -k1/M1 k1/M1 -b1/M1 b1/M1; k1/M2 -(k1+k2)/M2 b1/M2 -(b1+b2)/M2];
B = [0; 0; 1/M1; 0];
C = [1 0 0 0];
D = 0;
I = eye(4);

% Calculamos ganancias de control
Mc = [B A*B (A^2)*B (A^3)*B];
H = (A-pd(1)*I)*(A-pd(2)*I)*(A-pd(3)*I)*(A-pd(4)*I);
K = - [0 0 0 1]*(Mc^-1)*H;
F = 1/(C*((-A-B*K)^-1)*B);
eigs(A+B*K)

% Resuelve las ecuaciones diferenciales ordinarias (ODE's)
[t, X] = ode45(@Carritos_SegRef_sys, tspan, x0);

figure;
subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

ref = 2;
U = K*X' + F*ref;
maxU = max(abs(U))

figure;
plot(t,C*X','r',t,ref); title('SALIDA'); grid;
figure;
plot(t, U); title('SENAL DE CONTROL'); grid;


end


% Carritos_SegRef_plot([0:0.01:5], [0 0 0 0], [-4+0.8066i -4-0.8066i -22 -22])