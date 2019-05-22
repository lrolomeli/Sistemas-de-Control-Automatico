function Tarea2_3( tspan, x0)
%Variables globales 
global A B C Kp Ki Kd
 
%Matrices del sistema
A = [0 1 0; 0 0 1;16 -6 -9];
B = [0; 0; 1];
C = [1 0 0];
 
%Ganancias del controlador 
Kp = 4000; Ki = 0.25; Kd = 1700;
 
%Solucion de las escuaciones (ODE's)
[t, X] = ode45(@Tarea2_3_sys, tspan, [0 x0]);

%Referencia Constante
ref = 1; 
 
%Grafico salida y referencia
figure;
plot(t, ref, 'r', t, X(:,2:4)*C'); title('SALIDA Y REFERENCIA');
 
end
 
function dX = Tarea2_3_sys(t, X)

%Variables globales 
global A B C Kp Ki Kd

%Referencia Constante
ref = 1;

%Referencia Constante derivada
dref = 0;

%Ley de control
E = ref - C*X(2:4);
dE = dref - C*A*X(2:4);
iE = X(1);
U = Kp*E + Ki*iE + Kd*dE;
 
%ODE's
dX = [E; A*X(2:4) + B*U];
end

