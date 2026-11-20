rng(1)
n = 100;
group = [zeros(50, 1); ones(50, 1)];
for p_out = [0.05 0.15]
    P = p_out * ones(n);
    P(group == group') = 0.3;                     % same community
    A = triu(rand(n) < P, 1);
    A = double(A + A');                           % each pair joined at most once
    L = diag(sum(A, 2)) - A;
    [V, D] = eig(L);
    guess = V(:, 2) > 0;
    correct = max(sum(guess == group), sum(guess ~= group));  % the labels may be swapped
    fprintf('p_out = %.2f: lambda2 = %.2f, %d of %d correct\n', p_out, D(2, 2), correct, n)
end
