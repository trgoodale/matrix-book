n = 2000;
M = randn(n);
v = randn(n, 1);

tic; x1 = M \ v;      t1 = toc;
tic; x2 = inv(M) * v; t2 = toc;
fprintf('backslash: %.3f s, error %.1e\n', t1, norm(M*x1 - v));
fprintf('inv:       %.3f s, error %.1e\n', t2, norm(M*x2 - v));
