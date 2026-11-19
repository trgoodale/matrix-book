f = @(v) [v(1)^2 + v(2)^2 - 4; v(1)*v(2) - 1];
J = @(v) [2*v(1), 2*v(2); v(2), v(1)];

x = [2; 0.5];
for k = 0:4
    fprintf('%d  %.12f  %.12f  %.1e\n', k, x(1), x(2), norm(f(x)));
    x = x - J(x) \ f(x);                      % solve, don't invert
end

% Library solver (Optimization Toolbox)
x = fsolve(f, [2; 0.5], optimset('Display', 'off'))
