A = [4 1; 2 3];
[P, D] = eig(A);
norm(A - P*D/P)            % zero, up to rounding: A = P D P^(-1)

k = 5;
A^k
round(P * D^k / P)         % the same, from the eigenvalues

F = [1 1; 1 0];
F30 = F^30;
F30(1, 2)                  % the 30th Fibonacci number
