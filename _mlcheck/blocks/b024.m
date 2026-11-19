for n = [10 30 60]
    W = eye(n) - tril(ones(n), -1);
    W(:, end) = 1;
    x = randn(n, 1);
    xhat = W \ (W * x);
    [L, U, P] = lu(W);
    fprintf('n = %d: cond = %.1f, largest entry of U = %.1e, relative error = %.1e\n', ...
            n, cond(W), max(abs(U(:))), norm(xhat - x, inf) / norm(x, inf));
end
