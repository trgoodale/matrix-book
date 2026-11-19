for n = [10 20 40 80]
    [~, ops] = elimination_count(randn(n), randn(n,1));
    fprintf('n = %3d   operations = %7d   2n^3/3 = %9.0f   ratio = %.2f\n', ...
            n, ops, 2*n^3/3, ops/(2*n^3/3));
end

function [x, ops] = elimination_count(A, b)
% Gaussian elimination that also counts arithmetic operations.
n = length(b);
ops = 0;
for k = 1:n-1
    for i = k+1:n
        m = A(i,k) / A(k,k);
        A(i,k:n) = A(i,k:n) - m * A(k,k:n);
        b(i) = b(i) - m * b(k);
        ops = ops + 1 + 2*(n-k+1) + 2;   % divide, row update, right-hand side
    end
end
x = zeros(n,1);
for i = n:-1:1
    x(i) = (b(i) - A(i,i+1:n) * x(i+1:n)) / A(i,i);
    ops = ops + 2*(n-i) + 2;             % dot product, subtract, divide
end
end
