t = linspace(0, 1, 50)';
ns = [4 6 8 10 12];
conds = zeros(size(ns)); loss = zeros(3, numel(ns));
for k = 1:numel(ns)
    n = ns(k);
    A = t .^ (0:n-1);
    conds(k) = cond(A);
    [Qh, ~] = qr(A, 0);
    Qs = {classical_gs(A), modified_gs(A), Qh};
    for m = 1:3
        loss(m, k) = norm(Qs{m}' * Qs{m} - eye(n));
    end
end
loglog(conds, loss, 'o-')
xlabel('condition number of A'), ylabel('||Q^TQ - I||')
legend('classical', 'modified', 'Householder')

function Q = classical_gs(A)
Q = zeros(size(A));
for j = 1:size(A, 2)
    v = A(:, j) - Q(:, 1:j-1) * (Q(:, 1:j-1)' * A(:, j));
    Q(:, j) = v / norm(v);
end
end

function Q = modified_gs(A)
Q = A;
for j = 1:size(A, 2)
    Q(:, j) = Q(:, j) / norm(Q(:, j));
    for k = j+1:size(A, 2)
        Q(:, k) = Q(:, k) - (Q(:, j)' * Q(:, k)) * Q(:, j);
    end
end
end
