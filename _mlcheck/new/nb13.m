A = [4 1; 2 5];  b = [6; 12];  x_true = A \ b;
D = diag(diag(A));  L = tril(A, -1);
names = {'Jacobi', 'Gauss-Seidel'};
splits = {D, D + L};                 % the matrix M in A = M - N
for m = 1:2
    M = splits{m};  N = M - A;       % iterate M*x_new = N*x + b
    x = [0; 0];  err = norm(x - x_true);
    fprintf('%s, spectral radius %.4f\n', names{m}, max(abs(eig(M \ N))))
    for k = 1:6
        x = M \ (N*x + b);
        new_err = norm(x - x_true);
        fprintf('  step %d: error %.2e, ratio %.4f\n', k, new_err, new_err/err)
        err = new_err;
    end
end
