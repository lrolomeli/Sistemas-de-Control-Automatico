function obs(tspan, x0, K, Pd)

global A B C k pd

k = K;
pd = Pd;

A = [1 1 2; 2 3 -1; 1 -1 0];
B = [1 2; 3 1; 2 -3];
C = [1 0 0; 0 1 0];

% Mc = [B A*B (A^2)*B];
% Mo = [C; A*C; (A^2)*C];
% ((C*B)^-1)

[t, X] = ode45(@obs_sys, tspan, [x0 0 0 0]);

figure;
subplot(3,1,1); plot(t, X(:,1));hold on; plot(t, X(:,4),'red'); title('ESTADO 1'); grid;
subplot(3,1,2); plot(t, X(:,2));hold on; plot(t, X(:,5),'red'); title('ESTADO 2'); grid;
subplot(3,1,3); plot(t, X(:,3));hold on; plot(t, X(:,6),'red'); title('ESTADO 3'); grid;

end

function dX = obs_sys(t, X)

x = X(1:3); 
xo = X(4:6);

global A B C k pd

ref = [2+sin(t); 2+cos(t)];
dref = [cos(t); -sin(t)];

I = eye(3);
C1 = C(1,:);
Mo = [C1; C1*A; C1*(A^2)];
Ho = (A-pd(1)*I)*(A-pd(2)*I)*(A-pd(3)*I);
L = -Ho * Mo^-1*[0;0;1];
e = ref - C*x;

% xloca = [X(1); X(2); X(6)];

U = ((C*B)^-1)*(dref - C*A*xo - k*e);

Ye = C1*x - C1*xo;

dx = A*x + B*U;
dxo = A*xo + B*U - L*Ye;

dX = [dx;dxo];
end