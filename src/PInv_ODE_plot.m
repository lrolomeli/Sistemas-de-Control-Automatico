function PInv_ODE_plot(tspan, x0, pd)

global A B C K

% Matrices del sistema

A = [0 1 0 0; 20.601 0 0 0; 0 0 0 1; -0.4905 0 0 0];
B = [0; -1; 0; 0.5];
C = [1 0 1 0];
D = 0;
I = eye(4);
% Controlador
Mc = [B A*B (A^2)*B (A^3)*B];
rank(Mc)
Hc = (A-pd(1)*I)*(A-pd(2)*I)*(A-pd(3)*I)*(A-pd(4)*I);
K = -[0 0 0 1]*(Mc^-1)*Hc;
eigs(A+B*K) % Comprobando ubicacion de polos en lazo cerrado

% Resuelve las ecuaciones diferenciales ordinarias ODE

[t, X] = ode45(@PInv_ODE_sys, tspan, x0);

subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

figure;
U = K*X';
plot(t, U); title('Senal de Control'); grid;

end

