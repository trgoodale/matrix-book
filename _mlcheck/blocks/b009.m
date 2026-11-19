A = [1 2; 3 2];
[V, D] = eig(A);
lambda = diag(D)'
slopes = V(2, :) ./ V(1, :)
