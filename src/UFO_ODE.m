function UFO_ODE(tspan, x0)

global A B1 B2 G

% Parametros del sistema
M1 = 80; M2 = 150;
g = 9.81;
% Matrices del sistema
A = [0 1 0 0; 0 0 0 0; 0 0 0 1; 0 0 0 0];
U = 4500;
B1 = [0; U/M1; 0; 0];
B2 = [0; 0; 0; U/M2];
G = [0;-g;0;-g];

[t, X] = ode45(@sys, tspan, x0);
%Grafica de los estados
figure;
subplot(2,1,1); plot(t,X(:,1)); title('Estado 1'); grid;
subplot(2,1,2); plot(t,X(:,3)); title('Estado 3'); grid;

end

function dX = sys(t,X)

global A G B1 B2

if(t<3)
    dX = A*X + B1 + G;
else
    % ODE's
    dX = A*X + B2 + G;
end

end
% Llamado a funcion:
% UFO_ODE([0 10],[130 0 130 0])