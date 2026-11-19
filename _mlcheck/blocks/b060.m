A = [5 2; 2 2];
[Q, L] = eig(A)            % eigenvalues in increasing order for a symmetric matrix

B = [4 2 2; 2 5 3; 2 3 6];
R = chol(B)                % upper triangular, with B = R' * R (so R = L')

[~, p] = chol([1 2; 2 1]);
p                          % p > 0 means "not positive definite"
