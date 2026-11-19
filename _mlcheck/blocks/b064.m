0.1 + 0.2 == 0.3
eps

x = 1e-8;
[(1 - cos(x)) / x^2, 2 * sin(x/2)^2 / x^2]   % cancellation

A = [1 1; 1 1.01];
[cond(A, inf), cond(A)]

for n = [4 8 12]
    H = hilb(n);
    xtrue = ones(n, 1);
    xhat = H \ (H * xtrue);
    fprintf('n = %2d: cond = %.1e, error = %.1e\n', n, cond(H), norm(xhat - xtrue, inf));
end
