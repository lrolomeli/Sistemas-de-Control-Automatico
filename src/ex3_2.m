function ex3_2

global A B C Ke L

tspan = [0 10];
x0 = [2 3 0 0];
pd = -4;
pdo = -5;
% Matrices del sistema
A = [-1 -3 4 1; 0 -2 1 2; -1 -1 0 3; 2 -1 2 -1];
B = [2 1; 3 -0.5; 4 2; 1 1];
C = [3 0 0 0; 0 2 0 0];

% Calculamos ganancias de control
Ke = pd;
I = eye(4);
% Diseno del observador
Mo = [C;C*A;C*(A^2);C*(A^3)];
rank(Mo);
%  El sistema solo es observable para la salida x2
Ho = (A-pdo*I)*(A-pdo*I)*(A-pdo*I)*(A-pdo*I);
% L = -Ho*(Mo1^-1)*[0;0;0;1];


% Resuelve las ecuaciones diferenciales ordinarias
[t, X] = ode45(@ex3_2_sys, tspan, x0);

% Grafico los estados
figure;
subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

ref = [200+0*t  250+0*t];   dref = [0*t 0*t];

Y = X*C';

e = ref - Y;

U = (C*B)^-1*(dref - X*(C*A)' - Ke*e)';

figure; plot(t,Y(:,1), 'green', t, ref(:,1), 'red'); title('SALIDA1 Y REFERENCIA1'); grid;
figure; plot(t,Y(:,2), 'yellow', t, ref(:,2), 'blue'); title('SALIDA2 Y REFERENCIA2'); grid;
figure; plot(t, U(1,:)); title('ENTRADA'); grid;

end


function dX = ex3_2_sys(t, X)

global A B C Ke L

x = X(1:4);
% xo = X(5:8);

ref = [200+0*t; 250+0*t];   dref = [0*t; 0*t];

% Variable de Error
e = ref - C*x;

% Ley de Control
U = (C*B)^-1*(dref - C*A*x - Ke*e);
% Y = C*x;
% Ye = Y - C*xo;
%ODE's
dx = A*x + B*U;
% dxo = A*xo + B*U - L*Ye;
% dX = [dx;dxo];
dX = dx;

end