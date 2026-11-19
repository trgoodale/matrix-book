A = [3 1; 2 2];
[V, D] = eig(A)          % eigenvectors in the columns of V, eigenvalues on the diagonal of D
slopes = V(2, :) ./ V(1, :)

% The axis of a rotation: the invariant points, solving (C - I)x = 0
C = [0 0 1; 1 0 0; 0 1 0];
null(C - eye(3))         % a multiple of (1, 1, 1)
