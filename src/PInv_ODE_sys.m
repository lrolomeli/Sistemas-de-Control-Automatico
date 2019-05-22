function dX = PInv_ODE_sys(t, X)

global A B C K

U = K*X;    %Control por retro solo estabiliza el sistema
% U = K*X - 1; %Control por retro a una entrada escalon
% U = 1; %Entrada escalon
% U = 0; %Condiciones Iniciales

% ODE's
dX = A*X + B*U;
end