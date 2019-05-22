%% inciso_C([0 10],[2 3 0 0], -2)

function inciso_C(tspan, x0, pd)
global A B C Ke

% Matrices del sistema 
A = [-3 -2 3 0; 2 -5 1 3; 1 2 -3 0; 3 -1 1 -5];
B = [2; -3; 0; 0];
C = [1 0 0 0];

% Calculamos ganancias de control
Ke = pd;

% Resuelve las ecuaciones diferenciales ordinarias
[t, X] = ode45(@inciso_C_sys, tspan, x0);

% Grafico los estados
figure;
subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

ref = 2-2*exp(-t);   dref = 2*exp(-t);

Y = X*C';

e = ref - Y;

U = (C*B)^-1*(dref - X*(C*A)' - Ke*e)';

figure; plot(t,Y, 'green', t, ref, 'red'); title('SALIDA1 Y REFERENCIA1'); grid;
figure; plot(t, U); title('ENTRADA'); grid;

end

function dX = inciso_C_sys(t, X)

global A B C Ke

ref = 2-2*exp(-t);   dref = 2*exp(-t);

% Variable de Error
e = ref - C*X;

% Ley de Control
U = (C*B)^-1*(dref - C*A*X - Ke*e);

%ODE's
dX = A*X + B*U;

end