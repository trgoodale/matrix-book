%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 13: LU decomposition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-2/13-lu-decomposition.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% SciPy, the scientific companion to NumPy, has the factorisation in
% scipy.linalg. Watch out for one difference of convention: SciPy's lu
% returns P, L, U with A = PLU, so its P is the transpose of the P in PA =
% LU. MATLAB's lu follows the convention of this chapter.

A = [2 1 1; 4 3 3; 8 7 9];
[L, U, P] = lu(A)            % P*A = L*U

b = [4; 10; 24];
y = L \ (P*b);               % forward substitution
x = U \ y                    % back substitution

%%
% Partial pivoting chose 8, the largest entry in column 1, as the first
% pivot, so these factors differ from the ones found by hand. MATLAB's
% backslash notices that L and U are triangular, and uses forward and back
% substitution automatically.
%
% For many right-hand sides, either keep L, U and P and reuse them as above,
% or use decomposition, which stores the factors and reuses them each time
% you use backslash:

dA = decomposition(A, 'lu');
x1 = dA \ [4; 10; 24]
x2 = dA \ [1; 1; 1]

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part2.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-2.html#sec-solutions-lu-decomposition

%% Exercise 7
% Write a function forward_substitution(L, b) that solves Ly = b for a lower
% triangular L with 1s on its diagonal. Use it, with the back substitution
% from Chapter 11, to solve the systems in Exercise 2, and check your
% answers against a library solver.

% Your code here
