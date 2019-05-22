close all
clear
clc
%% Valores obtenidos mediante las mediciones
VOl_Mot = [12 11 10 9 8 7 6 5];
Vel_Angu = [814.053 769.998 718.440 640.842 563.252 481.603 400.305 346.840];
Vol_Conv = [5.07 4.66 4.26 3.78 3.30 2.89 2.41 1.93];

%% Graficas de los valores 
figure();
plot(VOl_Mot, Vel_Angu);
ylabel('w(t)');xlabel('v(t)');
figure();
plot(VOl_Mot, Vol_Conv);
ylabel('voltaje convertidor');xlabel('v(t)');

%% Relacion obtenida
figure();
plot(Vol_Conv, Vel_Angu);
xlabel('voltaje convertidor');ylabel('w(t)');

%% Codigo para graficar en matlab la funcion de tranferencia 
v = 7;
ts = 3.64;
ks = v/2.4;                  % Ganancia del sistema       
wn= 3/ts;                    % Frecuencia natural (criterio del 5%)
fa=1;                        % Factor de amortiguamiento
num = ks*wn^2;    % num del sys
den = [1 2*fa*wn wn^2];      % Denominador del sys
sys = tf(num,den);           % Función de tf
ra = roots(den);             % polos del sys
step(sys);
