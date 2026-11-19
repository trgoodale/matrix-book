A = [1 2 0 1;
     2 4 1 4;
     3 6 1 5];
r = rank(A)
N = null(A);               % columns: a basis for N(A)
size(N, 2)                 % the nullity
norm(A * N)                % zero (up to rounding): they solve Ax = 0
size(orth(A), 2)           % dimension of the column space
null(A')                   % left null space: a multiple of (1, 1, -1)
