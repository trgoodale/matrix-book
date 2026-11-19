for n = [10 20 40 80]
    e = ones(n, 1);
    T = spdiags([-e 2*e -e], -1:1, n, n);
    A = kron(speye(n), T) + kron(T, speye(n));
    b = zeros(n); b(1, :) = 100;
    tic; u = A \ b(:); td = toc;
    tic; [x, flag, relres, iters] = pcg(A, b(:), 1e-8, 1000); tc = toc;
    fprintf('n = %3d: direct %.4f s, CG %.4f s in %d steps\n', n, td, tc, iters);
end
U = reshape(u, n, n);
plot(linspace(0, 1, n), U(:, round(n/2)))    % temperature down the centre line
