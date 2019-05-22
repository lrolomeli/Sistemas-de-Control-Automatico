syms s t
F = ((5*s^2)+(.5*s)+4.905)/((0.5*s^3)+(0.1*s^2)+(0.2*s));
x = ilaplace(F,t);
t=-20:0.01:70;
% y(real) = x(symbolic)
y = 981/40 - (581*exp(-t/10).*(cos((39^(1/2)*t)/10) + (327*39^(1/2)*sin((39^(1/2)*t)/10))/7553))/40;
plot(t,y,'b','linewidth',1.5); grid;
xlabel('tiempo');
ylabel('y(t)');