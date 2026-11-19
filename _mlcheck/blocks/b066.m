n = 100000;
h = 1 / (n + 1);
e = ones(n, 1);
A = spdiags([-e 2*e -e], -1:1, n, n);   % sparse tridiagonal
b = h^2 * ones(n, 1);
u = A \ b;                               % sparse solver
t = (1:n)' * h;
max(abs(u - t .* (1 - t) / 2))           % error
nnz(A)
