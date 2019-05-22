function MassSpring_SS(x0)

% Parametros del sistema
M = 2; b = 6; k = 4;

% Matrices del sistema
A = [0 1; -k/M -b/M];
B = [0; 1/M];
C = [1 0];
D = 0;

% Definimos el modelo en SS
MassSpring_sys = ss(A,B,C,D);

% GRAFICANDO
% Condiciones iniciales
[y,t,x] = initial(MassSpring_sys, x0);
figure;
subplot(2,1,1); plot(t,x(:,1)); title('ESTADO 1'); grid;
subplot(2,1,2); plot(t,x(:,2)); title('ESTADO 2'); grid;

% Entrada senoidal
t = (0:0.01:20);
u = 2*sin(t);
[y,t,x] = lsim(MassSpring_sys, u, t, x0);
figure;
subplot(2,1,1); plot(t,x(:,1)); title('ESTADO 1'); grid;
subplot(2,1,2); plot(t,x(:,2)); title('ESTADO 2'); grid;

end