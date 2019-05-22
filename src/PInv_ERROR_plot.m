function PInv_ERROR_plot(tspan, x0, pd)

global A B C Ke

% Matrices del sistema
A = [0 1 0 0; 20.601 0 0 0; 0 0 0 1; -0.4905 0 0 0];
B = [0 0; -1 0; 0 0; 0.5 1];
C = [0 1 0 0; 0 0 0 1];

% Calculamos ganancias de control
Ke = pd;

% Resuelve las ecuaciones diferenciales ordinarias
[t, X] = ode45(@PInv_ERROR_sys, tspan, x0);

% Grafico los estados
figure;
subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

ref = [1.5*sin(t)  2+1.5*cos(t)];   dref = [1.5*cos(t)  -1.5*sin(t)];

Y = X*C';

e = ref - Y;

U = (C*B)^-1*(dref - X*(C*A)' - Ke*e)';

figure; plot(t,Y(:,1), 'green', t, ref(:,1), 'red'); title('SALIDA1 Y REFERENCIA1'); grid;
figure; plot(t,Y(:,2), 'yellow', t, ref(:,2), 'blue'); title('SALIDA2 Y REFERENCIA2'); grid;
figure; plot(t, U(1,:)); title('ENTRADA'); grid;

end
% PInv_ERROR_plot([0 10],[2 3 0 0], -2)
