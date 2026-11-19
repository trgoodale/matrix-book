L = [0 1.5 1; 0.6 0 0; 0 0.7 0];
[V, D] = eig(L);
[lam, i] = max(real(diag(D)));
lam
v = V(:, i) / sum(V(:, i))

x = [100; 0; 0];
for k = 1:50
    x = L * x;
end
x / sum(x)
