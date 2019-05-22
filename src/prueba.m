function prueba(tspan, x0)%condiciones iniciales x0

    [t, x] = ode45(@espacio_estados, tspan, x0);
    plot(t, x(:,1),'r',t,x(:,2),'b',t,x(:,3),'g');
end

function dx = espacio_estados(t, x)

    g = 9.81; r =0.5; kt = 0.1; kb = 0.1;
    M = 80;
    J = 0.02;
    b = 0.02;
    b2 = 0.02;
    L = 1e-3;
    A = [(-r/L) 0 (kb*r)/L; 0 0 1; kt/(r*M - r*J) 0 (b-b2)];
    groot = eigs(A);
    B = [1/L; 0; 0];
    if(t>=10)
        u = 20;
    else
        u = 0;
    end

    dx = A*x+B*u+[0;0;-r*M*g];

end