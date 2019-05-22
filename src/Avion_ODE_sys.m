function dX = Avion_ODE_sys(t, X)

global A B C D K F

ref = 1.5;  
% ref = 1.5 * sin(t); % Que tal con referencias no constantes

U = K*X + F*ref;

% ODE's
dX = A*X + B*U;

end