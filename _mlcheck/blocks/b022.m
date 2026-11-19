A = [-0.5 0; 0.5 -0.2];
t = linspace(0, 20, 2001);
X = zeros(2, numel(t));
for j = 1:numel(t)
    X(:, j) = expm(A * t(j)) * [100; 0];
end
[peak, j] = max(X(2, :));
[t(j), peak]               % time and amount of the peak
plot(t, X)
xlabel('time (hours)'), ylabel('amount (mg)'), legend('gut', 'blood')
