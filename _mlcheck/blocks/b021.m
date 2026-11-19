A = [10 0; 0 1];
for alpha = [0.1 0.18 0.21]
    x = [1; 1];
    k = 0;
    while norm(x) >= 1e-6 && k < 1000
        x = x - alpha * (A * x);
        k = k + 1;
    end
    fprintf('alpha = %.2f: %d steps, |x| = %.3g\n', alpha, k, norm(x));
end
