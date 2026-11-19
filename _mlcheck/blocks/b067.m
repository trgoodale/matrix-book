n = 50;
A = 2*eye(n) - diag(ones(n-1,1), 1) - diag(ones(n-1,1), -1);
b = ones(n, 1) / (n + 1)^2;
D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);

rho = max(abs(eig(D \ (L + U))));
w = 2 / (1 + sqrt(1 - rho^2));
names = {'Jacobi', 'Gauss-Seidel', 'SOR'};
M = {D, D + L, D/w + L};
N = {L + U, U, U + (1 - 1/w)*D};

for m = 1:3
    x = zeros(n, 1);
    k = 0;
    while norm(b - A*x) >= 1e-6 * norm(b)
        x = M{m} \ (b - N{m}*x);       % M is diagonal or triangular
        k = k + 1;
    end
    fprintf('%-13s %5d steps\n', names{m}, k);
end

[x, flag, relres, iters] = pcg(A, b, 1e-6, 100);
fprintf('%-13s %5d steps\n', 'CG', iters);
