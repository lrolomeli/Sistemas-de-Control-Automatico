function ERROR_BLOQUES_plot(tspan, x0, K)

global A B C k1 k2 k3

k1 = K(1); k2 = K(2); k3 = K(3);

% Matrices del sistema
A = [-4 4 0 2; 0 -3 3 0; 0 2 -5 0; 1 1 -4 -5];
B = [0; 0; 10; 0];
C = [1 0 0 0];

figure;
subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

Y = X*C';

figure; plot(t, Y, t, ref, 'red')
end


function dX = ERROR_BLOQUES_sys(t, X)

global A B C k1 k2 k3

x1 = X(1); x2 = X(2); x3 = X(3); x4 = X(4);

dx1 = A(1,:)*X; dx2 = A(2,:)*X; dx3 = A(3,:)*X; dx4 = A(4,:)*X;

ddx1 = 4*dx1 + 4*dx2 + 2*dx4;
ddx4 = dx1 + dx2 - 4*dx3 - 5*dx4;


% Referencias y Derivadas
ref = -3 + cos(2*t); 
dref = -2 * sin(2*t);
ddref = 4 * cos(2*t); 
dddref = -8 * sin(2*t);

%Variable de error
e1 = ref - C*X;
de1 = dref-dx1;
dde1 = ddref - ddx1;
x2ref = (dref+4*x1-2*x4-k1*e1)/4;
dx2ref = (ddref + 4*dx1 - 2*dx4 - k1*de1)/4;
ddx2ref = (dddref + 4*ddx1 - 2*ddx4 - k1*dde1)/4;

e2 = x2ref - x2;
de2 = dx2ref-dx2;
x3ref = (dx2ref+3*x2-k2*e2)/3;
dx3ref = (ddx2ref + 3*dx2-k2*de2)/3;

e3 = x3ref - x3;
U = (dx3ref - 2*x2 + 5*x3 - k3*e3)/10;

dX = A*X + B*U;

end