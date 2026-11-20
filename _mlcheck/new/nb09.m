A = [2 1 1; 4 3 3; 8 7 9];
[L, U, P] = lu(A);               % P*A = L*U, factorised once
solve = @(b) U \ (L \ (P*b));    % each solve is two triangular solves
fprintf('x = %g %g %g\n', solve([4; 10; 24]))
I = eye(3);
Ainv = [solve(I(:,1)), solve(I(:,2)), solve(I(:,3))]
fprintf('Agrees with inv(A): %d\n', norm(Ainv - inv(A)) < 1e-12)
