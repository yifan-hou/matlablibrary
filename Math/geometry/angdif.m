function dif = angdif(a, b)
dif = a - b;
dif = mod(dif+pi, 2*pi) - pi;