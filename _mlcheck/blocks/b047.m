A = [0.6 0.8 0.5;
     0.3 0.1 0.2;
     0.1 0.1 0.3];
b = [60; 22; 18];

x = A \ b
A*x - b              % the residual: zero, up to rounding
