function dX = Carritos_ERROR_BLOQUES_sys(t, X)

global A B C K1 K3 M1

% Referencias y Derivadas
ref = 1 + 0.5*sin(t); 
dref = 0.5*cos(t); 
ddref = -0.5*sin(t);

% Senales de error
e1 = ref - X(1); 
X3r = dref - K1*e1;
e3 = X3r - X(3); 
dX3r = ddref - K1*(dref - X(3));

% Ley de control
U = M1*(dX3r - K3*e3 - A(3,:)*X); % Control por bloques

% ODE's

dX = A*X + B*U;

end