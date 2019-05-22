function dX = PInv_ERROR_sys(t, X)

global A B C Ke

ref = [1.5*sin(t); 2+1.5*cos(t)];   dref = [1.5*cos(t); -1.5*sin(t)];

% Variable de Error
e = ref - C*X;

% Ley de Control
U = (C*B)^-1*(dref - C*A*X - Ke*e);

%ODE's
dX = A*X + B*U;

end