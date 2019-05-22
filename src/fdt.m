Jm = 5; B = 1; K = 0.5;
num = [1 0];
den = [Jm B K];
sys = tf(num, den);
r = roots(den);
step(sys);