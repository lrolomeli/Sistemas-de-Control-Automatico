format rat
b = [1 3];
a = [1 3 0.05];

[r,p,k] = residue(b,a)

t=0:0.01:500;
x = r(1)*exp(p(1)*t) + r(2)*exp(p(2)*t);

plot(t,x);
%%
x = 1.0056*exp(-0.016*t) - 0.0056*exp(-2.98*t);
plot(t,x);
plot(t,x,'b','linewidth',1.5); grid;
xlabel('tiempo');
ylabel('y(t)');

%%
format rat
b = [1 1];
a = [1 1 2];

[r,p,k] = residue(b,a)

t=0:0.01:30;
x = r(1)*exp(p(1)*t) + r(2)*exp(p(2)*t);

plot(t,x);

%%
t=0:0.01:20;
x = (cos((sqrt(7)/2)*t) + (1/sqrt(7))*sin((sqrt(7)/2)*t)).*exp(-t/2);
plot(t,x,'b','linewidth',1.5); grid;
xlabel('tiempo');
ylabel('y(t)');

%%
g = 9.81;
t=0:0.01:50;
x = ((-1+(g/2))*exp(-2*t)) + ((2-g)*exp(-t)) + (g/2);
plot(t,x,'b','linewidth',1.5); grid;
xlabel('tiempo');
ylabel('y(t)');

%%

t=0:0.01:70;
x = -(581/40)*(exp(-(1/10)*t)).*(cos(sqrt(39/100)*t)) + ((581/400)-(781/200))*sqrt(100/39)*(exp(-(1/10)*t)).*(sin(sqrt(39/100)*t)) + (981/40);
plot(t,x,'b','linewidth',1.5); grid;
xlabel('tiempo');
ylabel('y(t)');
