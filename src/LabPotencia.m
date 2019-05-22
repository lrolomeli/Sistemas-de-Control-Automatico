clear;clc;close all;
%--------------- Valores de diseño a tunear -------------------------

% Frecuencia de switcheo
freq = 118e3;
t = 1/freq;
% Voltaje de entrada
V_i = 2.7; % 2.7 < V_i < 4.2

%--------------- Valores de diseño FIJOS -------------------------
% Voltaje de salida
V_o = 9;

% Corriente de salida
I_o = 1;

% Ripple de corriente porcientual
Porc_ripple_corriente = 0.4;

% Ripple de voltaje porcientual
Porc_ripple_voltaje = 0.02;

%----------------------------------------------------------------------------

% Resistencia de carga
R_load = V_o/I_o;
disp(["Valor de resistencia ladrillo",num2str(R_load),"Ohms"]);

% Duty cycle
D = (V_o-V_i)/V_o;
disp(["Duty cycle %",num2str(D*100)]);

% Corriente de la fuente
I_supply = I_o/(1-D);

% Ripple de corriente
I_ripple = Porc_ripple_corriente*I_supply;

% Valor del Inductor
L = (V_i*D)/(freq*I_ripple);
disp(["Valor del inductor minimo: ",num2str(1e6*L),"microHenrys"]);

% Ripple de voltaje
V_ripple = Porc_ripple_voltaje*V_o;

% Valor del capacitor
C = (I_o*D)/(freq*V_ripple);
disp(["Valor del Capacitor minimo: ",num2str(1e6*C),"microFarads"]);








