A = [2 1 1; 4 3 3; 8 7 9];
[L, U, P] = lu(A)            % P*A = L*U

b = [4; 10; 24];
y = L \ (P*b);               % forward substitution
x = U \ y                    % back substitution
