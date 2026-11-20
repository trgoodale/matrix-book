A = [-2 1; 1 -2];  x0 = [1; 0];  t = 1;
x_expm = expm(A*t) * x0;
[V, D] = eig(A);
x_eig = V * diag(exp(diag(D)*t)) / V * x0;
x_formula = 0.5*exp(-t)*[1; 1] + 0.5*exp(-3*t)*[1; -1];
fprintf('%.6f %.6f\n', [x_expm, x_eig, x_formula])
