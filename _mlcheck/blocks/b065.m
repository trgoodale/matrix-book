A = [1e-20 1; 1 1];
b = [1; 2];
x_naive = solve_ge(A, b, false)    % wrong: [0; 1]
x_pivot = solve_ge(A, b, true)     % right: [1; 1]

A = [1 2 1; 2 6 1; 4 8 6];
[L, U, P] = lu(A)                  % P*A = L*U

function x = solve_ge(A, b, pivot)
% Solve Ax = b by Gaussian elimination, with or without partial pivoting.
n = length(b);
for k = 1:n-1
    if pivot
        [~, p] = max(abs(A(k:n, k)));   % row of the largest entry
        p = p + k - 1;
        A([k p], :) = A([p k], :);      % swap rows k and p
        b([k p]) = b([p k]);
    end
    for i = k+1:n
        m = A(i,k) / A(k,k);
        A(i,k:n) = A(i,k:n) - m * A(k,k:n);
        b(i) = b(i) - m * b(k);
    end
end
x = zeros(n,1);
for i = n:-1:1
    x(i) = (b(i) - A(i,i+1:n) * x(i+1:n)) / A(i,i);
end
end
