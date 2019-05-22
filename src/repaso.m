%% repaso

function repaso

global A B B_ C C1 k L

close all;
clc;

tspan = [0 5];
x0 = [2 2 2 2];
pd = -2;
pdo = -5;

I = eye(4);
% Matrices del sistema
A = [1 -4 3 2; 2 -2 2 1; 4 3 -1 1; 3 1 -3 1];
B = [1 3 0; -2 -6 1; 0 1 -1; 0 -2 1];
B_ = B(:,2:3);
C = [1 1 -2 -1; 3 -2 4 2];

C1 = C(1,:);

% Diseno del observador
Mo = [C1;C1*A;C1*(A^2);C1*(A^3)];
rank(Mo);
Ho = (A-pdo*I)*(A-pdo*I)*(A-pdo*I)*(A-pdo*I);
L = -Ho*(Mo^-1)*[0;0;0;1];


% Calculamos ganancias de control
k = pd;

% Resuelve las ecuaciones diferenciales ordinarias
[t, X] = ode45(@repaso_sys, tspan, [x0 0 0 0 0]);

% Grafico los estados
figure;
subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

ref1 = 2*cos(3*t);
ref2 = 2+2*tanh(5-t);
Y = X(:,1:4)*C';

figure;
subplot(4,1,1); plot(t,X(:,1),t,X(:,5),'--r'); title('Estado 1 y estimacion'); grid;
subplot(4,1,2); plot(t,X(:,2),t,X(:,6),'--r'); title('Estado 2 y estimacion'); grid;
subplot(4,1,3); plot(t,X(:,3),t,X(:,7),'--r'); title('Estado 3 y estimacion'); grid;
subplot(4,1,4); plot(t,X(:,4),t,X(:,8),'--r'); title('Estado 4 y estimacion'); grid;

figure;
subplot(4,1,1); plot(t, X(:,1)-X(:,5)); title('Error de Observador X1'); grid;
subplot(4,1,2); plot(t, X(:,2)-X(:,6)); title('Error de Observador X2'); grid;
subplot(4,1,3); plot(t, X(:,3)-X(:,7)); title('Error de Observador X3'); grid;
subplot(4,1,4); plot(t, X(:,4)-X(:,8)); title('Error de Observador X4'); grid;
figure; 
subplot(2,1,1); plot(t,Y(:,1), 'green', t, ref1, 'red'); title('SALIDA1 Y REFERENCIA1'); grid;
subplot(2,1,2); plot(t,Y(:,2), 'yellow', t, ref2, 'blue'); title('SALIDA2 Y REFERENCIA2'); grid;
% figure; plot(t, U_(1,:)); title('ENTRADA'); grid;

end
% PInv_ERROR_plot([0 10],[2 3 0 0], -2)


function dX = repaso_sys(t, X)

global A B B_ C k C1 L

x = X(1:4);
xo = X(5:8);

ref = [2*cos(3*t); 2+2*tanh(5-t)];   
dref = [-6*sin(3*t); -2*(sech(5-t)^2)];

x_ = [(C(2,:)*x+2*C(1,:)*x)/5;X(6);X(7);X(8)];


% Variable de Error
e = ref - C*x;

% Ley de Control
U_ = (C*B_)^-1*(dref - C*A*x_ - k*e);
U = [0; U_];

Y = C1*x;
Ye = Y - C1*xo;


%ODE's
dx = A*x + B*U;
dxo = A*xo + B*U - L*Ye;


dX = [dx;dxo];

end
