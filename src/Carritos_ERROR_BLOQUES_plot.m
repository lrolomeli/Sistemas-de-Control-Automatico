function Carritos_ERROR_BLOQUES_plot(tspan, x0, pd)

global A B M1 K1 K3

% Parametros del sistema
k1 = 150; k2 = 700; b1 = 15; b2 = 30; M1 = 5; M2 = 20;

% Matrices del sistema
A = [0 0 1 0; 0 0 0 1; -k1/M1 k1/M1 -b1/M1 b1/M1; k1/M2 -(k1+k2)/M2 b1/M2 -(b1+b2)/M2];
B = [0; 0; 1/M1; 0];
C = [1 0 0 0];

% Calculamos ganancias de control
K1 = pd; K3 = -10;

% Resuelve las ecuaciones diferenciales ordinarias (ODE's)
[t, X] = ode45(@Carritos_ERROR_BLOQUES_sys, tspan, x0);

% Referencias y Derivadas
ref = 1 + 0.5*sin(t); 
dref = 0.5*cos(t); 
ddref = -0.5*sin(t);

% Senales de error
e1 = ref - X(:,1);
X3r = dref - K1*e1;
e3 = X3r - X(:,3);
dX3r = ddref - K1*(dref - X(:,3));

% Ley de control
U = M1*(-X*A(3,:)' + dX3r - K3*e3); % Control por bloques

figure;
subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

figure; plot(t, C*X', 'r', t, ref); title('SALIDA'); grid;
figure; plot(t, U); title('SENAL DE CONTROL'); grid;

end