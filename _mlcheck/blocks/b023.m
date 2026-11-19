ns = 2:14;
conds = zeros(size(ns));
errors = zeros(size(ns));
for k = 1:numel(ns)
    n = ns(k);
    H = hilb(n);
    xhat = H \ (H * ones(n, 1));
    conds(k) = cond(H);
    errors(k) = max(abs(xhat - 1));
end
semilogy(ns, conds, 'o-', ns, errors, 's-', ns, conds * 1.1e-16, '--')
xlabel('n'), legend('condition number', 'error in solution', 'condition number \times \epsilon/2')
