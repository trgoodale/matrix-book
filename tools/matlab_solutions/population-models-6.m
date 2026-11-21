A = [0      0      0      0      127    4      80;
     0.6747 0.7370 0      0      0      0      0;
     0      0.0486 0.6610 0      0      0      0;
     0      0      0.0147 0.6907 0      0      0;
     0      0      0      0.0518 0      0      0;
     0      0      0      0      0.8091 0      0;
     0      0      0      0      0      0.8091 0.8089];
[V, E] = eig(A);
[lambda, k] = max(real(diag(E)));
stable = real(V(:, k)) / sum(real(V(:, k)));

x = [1000; 0; 0; 0; 0; 0; 0];
totals = zeros(100, 1); gaps = zeros(100, 1);
for year = 1:100
    x = A * x;
    totals(year) = sum(x);
    gaps(year) = max(abs(x / sum(x) - stable));
end
figure; semilogy(1:100, totals)
xlabel('year'); ylabel('total population')
slope = log(totals(100) / totals(90)) / 10     % compare with log(lambda)
log(lambda)
settled = find(gaps >= 0.01, 1, 'last') + 1    % within 1% from this year on
