A = [2 1 -1; -3 -1 2; -2 1 2];
b = [8; -11; -3];
x = gaussian_elimination(A, b)

function x = gaussian_elimination(A, b)
% Solve Ax = b by Gaussian elimination without pivoting.
n = length(b);

% Forward elimination
for k = 1:n-1
    if A(k,k) == 0
        error('Zero pivot in row %d: a row swap is needed', k);
    end
    for i = k+1:n
        m = A(i,k) / A(k,k);          % multiplier
        A(i,k:n) = A(i,k:n) - m * A(k,k:n);
        b(i) = b(i) - m * b(k);
    end
end

% Back substitution
x = zeros(n,1);
for i = n:-1:1
    x(i) = (b(i) - A(i,i+1:n) * x(i+1:n)) / A(i,i);
end
end
