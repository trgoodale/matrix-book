A = randn(2); B = randn(2);
norm((A*B)' - B'*A') < 1e-12      % true
norm(A*B - B*A) < 1e-12           % false (almost always)

S = [2 1; 1 2];
M = [1 2; 2 1];                   % a candidate
isequal(S*M, M*S)                 % true
