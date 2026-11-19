% A plate with a hot top edge
n = 49;
e = ones(n, 1);
T = spdiags([-e 2*e -e], -1:1, n, n);
I = speye(n);
A = kron(I, T) + kron(T, I);
b = zeros(n, n);
b(1, :) = 100;                       % neighbours on the hot edge
u = A \ b(:);
U = reshape(u, n, n);
size(A), nnz(A)
U((n+1)/2, (n+1)/2)                  % centre temperature

[x, flag, relres, iters] = pcg(A, b(:), 1e-8, 500);
iters                                % CG steps
imagesc(U), colorbar, axis equal tight
