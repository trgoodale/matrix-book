rng(1)
A = randn(4);  B = randn(4);
fprintf('(AB)^-1 = B^-1 A^-1: %d\n', norm(inv(A*B) - inv(B)*inv(A)) < 1e-10)
fprintf('(AB)^-1 = A^-1 B^-1: %d\n', norm(inv(A*B) - inv(A)*inv(B)) < 1e-10)
