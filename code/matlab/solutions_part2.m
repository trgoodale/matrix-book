%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part II: Linear systems: solutions to the code exercises
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Worked solutions to the code exercises from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/appendices/solutions-2.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Try each exercise yourself first. Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

% --------------------------------------------------------------------------
% Chapter 10: Systems of linear equations
% --------------------------------------------------------------------------

%% Chapter 10, exercise 7
% In Example 1, find the mixture for a new alloy of 100 kg containing 65 kg
% of copper, 20 kg of zinc and 15 kg of tin. Then try 55 kg of copper, 30 kg
% of zinc and 15 kg of tin. What goes wrong, and what does it mean for the
% workshop?

A = [0.6 0.8 0.5; 0.3 0.1 0.2; 0.1 0.1 0.3];
x1 = A \ [65; 20; 15]
x2 = A \ [55; 30; 15]

% The first alloy needs 37.5 kg of alloy 1, 37.5 kg of alloy 2 and 25 kg of
% alloy 3. The second "needs" -12.5 kg of alloy 2, which is impossible: the
% workshop can't add a negative amount. The equations have a solution, but
% it has no physical meaning, so this alloy can't be made from these three
% scraps. In the column picture, b can be made from the columns, but not
% with amounts that are all positive.

% --------------------------------------------------------------------------
% Chapter 11: Gaussian elimination
% --------------------------------------------------------------------------

%% Chapter 11, exercise 6
% Add a counter to the gaussian_elimination function that counts every
% multiplication, division, addition and subtraction. Run it on random
% systems with n = 10, 20, 40, 80, and compare the counts with (2/3)n^3.

% One way to count operations:

for n = [10 20 40 80]
    [~, ops] = elimination_count(randn(n), randn(n,1));
    fprintf('n = %3d   operations = %7d   2n^3/3 = %9.0f   ratio = %.2f\n', ...
            n, ops, 2*n^3/3, ops/(2*n^3/3));
end

% The ratio approaches 1 as n grows. For small systems the lower-order
% terms, such as the n^2 operations of back substitution, still matter.

% --------------------------------------------------------------------------
% Chapter 12: Gauss–Jordan elimination and rank
% --------------------------------------------------------------------------

%% Chapter 12, exercise 8
% In photosynthesis, plants turn carbon dioxide and water into glucose and
% oxygen: a CO_2 + b H_2O → c C_6H_12O_6 + d O_2. Write the atom balances
% for carbon, hydrogen and oxygen as a homogeneous system (as in Example 3),
% find its reduced row echelon form with code, and use it to balance the
% equation with the smallest whole numbers.

% The balances are: carbon, a = 6c; hydrogen, 2b = 12c; oxygen, 2a + b = 6c
% + 2d. As a homogeneous system in a, b, c, d:

M = [1 0 -6 0;           % carbon
     0 2 -12 0;          % hydrogen
     2 1 -6 -2];         % oxygen
rref(M)

% The free variable is d, and the rows say a = d, b = d and c = d/6. The
% smallest whole numbers come from d = 6:
% 6 CO_2 + 6 H_2O longrightarrowC_6H_12O_6 + 6 O_2.

% --------------------------------------------------------------------------
% Chapter 13: LU decomposition
% --------------------------------------------------------------------------

%% Chapter 13, exercise 7
% Write a function forward_substitution(L, b) that solves Ly = b for a lower
% triangular L with 1s on its diagonal. Use it, with the back substitution
% from the chapter, to solve the systems in Exercise 2, and check your
% answers against a library solver.

L = [1 0 0; 2 1 0; 3 2 1];
U = [1 1 1; 0 1 2; 0 0 1];
A = L * U;
b = [3; 9; 16];
x = U \ forward_substitution(L, b)
norm(x - A \ b)              % zero: the answers agree

% --------------------------------------------------------------------------
% Part II: Linear systems review
% --------------------------------------------------------------------------

%% Part II, exercise 8
% For the matrix in exercise 4, factorise once (with lu_factor in Python or
% lu in MATLAB), then solve for the right-hand sides (4, 10, 24)^T, e_1, e_2
% and e_3. Use the last three solutions to build A^-1, and compare it with
% the built-in inverse.

% Uses the chapter and the chapter.

A = [2 1 1; 4 3 3; 8 7 9];
[L, U, P] = lu(A);               % P*A = L*U, factorised once
solve = @(b) U \ (L \ (P*b));    % each solve is two triangular solves
fprintf('x = %g %g %g\n', solve([4; 10; 24]))
I = eye(3);
Ainv = [solve(I(:,1)), solve(I(:,2)), solve(I(:,3))]
fprintf('Agrees with inv(A): %d\n', norm(Ainv - inv(A)) < 1e-12)

% This is how software finds an inverse when one is really needed: one
% factorisation, then one cheap solve per column.

%% Functions
% MATLAB needs the functions used in a script to come at its end.

function [x, ops] = elimination_count(A, b)
% Gaussian elimination that also counts arithmetic operations.
n = length(b);
ops = 0;
for k = 1:n-1
    for i = k+1:n
        m = A(i,k) / A(k,k);
        A(i,k:n) = A(i,k:n) - m * A(k,k:n);
        b(i) = b(i) - m * b(k);
        ops = ops + 1 + 2*(n-k+1) + 2;   % divide, row update, right-hand side
    end
end
x = zeros(n,1);
for i = n:-1:1
    x(i) = (b(i) - A(i,i+1:n) * x(i+1:n)) / A(i,i);
    ops = ops + 2*(n-i) + 2;             % dot product, subtract, divide
end
end

function y = forward_substitution(L, b)
% Solve Ly = b, for L lower triangular with 1s on its diagonal.
n = length(b);
y = zeros(n, 1);
for i = 1:n
    y(i) = b(i) - L(i, 1:i-1) * y(1:i-1);
end
end
