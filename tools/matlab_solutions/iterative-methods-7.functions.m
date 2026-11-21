function steps = count_steps(n)
% Steps each method needs to reduce the residual by a factor of 10^6.
% Jacobi and Gauss-Seidel are skipped (NaN) for n > 100: too slow.
e = ones(n, 1);
A = spdiags([-e 2*e -e], -1:1, n, n);
b = e / (n + 1)^2;
D = diag(diag(A)); L = tril(A, -1); U = triu(A, 1);
rho = cos(pi / (n + 1));
w = 2 / (1 + sqrt(1 - rho^2));
Ms = {D, D + L, D / w + L};
Ns = {L + U, U, U + (1 - 1/w) * D};
steps = nan(1, 4);
for m = 1:3
    if m < 3 && n > 100, continue, end
    x = zeros(n, 1); k = 0;
    while norm(b - A*x) >= 1e-6 * norm(b)
        x = Ms{m} \ (b - Ns{m} * x);    % Ms{m} is triangular, so this is cheap
        k = k + 1;
    end
    steps(m) = k;
end
[~, ~, ~, steps(4)] = pcg(A, b, 1e-6, n);
end
