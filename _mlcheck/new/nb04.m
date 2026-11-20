m = 1; k = 100; n = 10;
K = k * (2*eye(n) - diag(ones(n-1, 1), 1) - diag(ones(n-1, 1), -1));
omega = sqrt(eig(K) / m);                         % M = m*I, so an ordinary eigenproblem
exact = 2*sqrt(k/m) * sin((1:n)' * pi / (2*(n+1)));
fprintf('agree: %d\n', max(abs(omega - exact)) < 1e-12)

n = 30;                                           % mode shapes for a longer chain
K = 2*eye(n) - diag(ones(n-1, 1), 1) - diag(ones(n-1, 1), -1);
[V, ~] = eig(K);
plot(1:n, V(:, 1:3), 'o-')
xlabel('mass number'); ylabel('displacement'); legend('mode 1', 'mode 2', 'mode 3')
