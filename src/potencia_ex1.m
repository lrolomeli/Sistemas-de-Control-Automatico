%% Prueba Final
f = 200e3;
Vs = 2.7;
I = 1;
Vo = 9;
D = 1 - Vs/Vo;

V_ripple = Vo*0.02;
I_ripple = 0.4 * I * Vo/Vs;


R = Vo/I;
L = Vs * (Vo - Vs)/((I*I_ripple) * f * Vo);
C = I*D/(f*V_ripple);

%% Prueba 1
f = 20e3;
t = 1/f;
Vs = 2.7;
I = 1;
Vo = 9;
D = 1 - Vs/Vo;

V_ripple = Vo*0.02;
I_ripple = 0.4 * I * Vo/Vs;


R = Vo/I;
% L = abs( ((Vs-Vo)*(1-D))/(f*(I*I_ripple)) );
L = Vs * (Vo - Vs)/((I*I_ripple) * f * Vo);
% C = abs( ((Vs-Vo)*(1-D))/(8*L*V_ripple*Vo*(f^2)) );
C = I*D/(f*V_ripple);

%% Prueba 2

f = 200e3;
t = 1/f;
Vs = 2.7;
I = 1;
V_ripple = 0.02;
I_ripple = 0.4;
Vo = 9;
D = 1 - Vs/Vo;
Imax = (I*(1+I_ripple));
R = Vo/I;
L = abs( ((Vs-Vo)*(1-D))/(f*(I*I_ripple)) );
% C = abs( ((Vs-Vo)*(1-D))/(8*L*V_ripple*Vo*(f^2)) );
% C = (Imax * D)/(f*V_ripple)
C = 245e-6;
vout_ripple = (Imax * D)/(f*C);

%% clase potencia 26/03/2019
freq = 60;
T = 1/freq;
L = 25e-3;
R = 10;
tau = L/R;
Vdc = 100;
Imax = (1-exp(-T/2*tau)/1+exp(-T/2*tau))*(Vdc/R);
Imin = -Imax;

io = (Vdc/R) + (-Imin-(Vdc/R))*exp(-T/tau);
% Corriente de salida
% io1 = -(Vdc/R) + (Imax+(Vdc/R))*exp(-(T-(T/2))/tau);

% Resultado del calculo de valor RMS de corriente salida (io)
Irms = 6.64;
Pprom = (Irms^2)*R; %WATTS

% Encuentre la corriente promedio de la fuente
Iprom_source = Pprom/Vdc; % Voltaje promedio