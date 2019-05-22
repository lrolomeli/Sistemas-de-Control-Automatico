function dX = Carritos_SegRef_sys(t, X)

global A B C K F

ref = 2;

U = K*X + F*ref;
% U = 10;

% ODE's
dX = A*X + B*U;

end