function MasaResorte_PID_DISC(tspan, T, x0, K)

Kp = K(1);
Ki = K(2);
Kd = K(3);

% Version Continua
A = [0 1; -0.5 -1];
B = [0;1];
C = [1 0];

% Version Discreta
Ad = eye(2)+T*A;
Bd = T*B;
Cd = C;

% Reservamos espacio en memoria
t = (tspan(1):T:tspan(2)); % vector de tiempo
n = size(t);

X = zeros(2, n(2));
E = zeros(1, n(2));
U = zeros(1, n(2));

ref = 1*ones(1,n(2)); % escalon unitario

X(:,1) = [x0(1); x0(2)]; % condiciones iniciales
UIm1 = 0;
Em1 = 0;

for i = 1 : size(t, 2)-1
    E(:,i) = ref(:,i) - Cd*X(:,i);
    UP = Kp*E(:,i);
    UI = UIm1 + Ki*T*E(:,i);
    UD = Kd * (E(:,i) - Em1)/T;
    
    U(:,i) = UP + UI + UD;
    
    X(:,i+1) = Ad*X(:,i)+Bd*U(:,i);
    
    UIm1 = UI;
    Em1 = E(:,i); % recursividad
end

figure;
subplot(2,1,1);
stairs(t,X(1,:), 'r');
title('Estado 1');

subplot(2,1,2);
stairs(t,X(2,:), 'r');
title('Estado 2');

figure;
stairs(t,C*X);
title('Salida');
hold on;
stairs(t, ref, 'red');
hold off;
grid;

end