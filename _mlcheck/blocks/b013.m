L = [1 0 0; 2 1 0; 3 2 1];
U = [1 1 1; 0 1 2; 0 0 1];
A = L * U;
b = [3; 9; 16];
x = U \ forward_substitution(L, b)
norm(x - A \ b)              % zero: the answers agree

function y = forward_substitution(L, b)
% Solve Ly = b, for L lower triangular with 1s on its diagonal.
n = length(b);
y = zeros(n, 1);
for i = 1:n
    y(i) = b(i) - L(i, 1:i-1) * y(1:i-1);
end
end
