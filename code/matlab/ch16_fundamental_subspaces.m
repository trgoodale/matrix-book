%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 16: Column space, null space and rank–nullity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-3/16-fundamental-subspaces.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% SciPy's null_space and orth, and MATLAB's null and orth, return bases for
% the null space and column space. They give orthonormal bases
% (perpendicular vectors of length 1, the chapter), computed from the
% singular value decomposition, so they look different from the bases found
% by hand. They span the same subspaces, which you can check by testing that
% A times each null space vector is zero.

A = [1 2 0 1;
     2 4 1 4;
     3 6 1 5];
r = rank(A)
N = null(A);               % columns: a basis for N(A)
size(N, 2)                 % the nullity
norm(A * N)                % zero (up to rounding): they solve Ax = 0
size(orth(A), 2)           % dimension of the column space
null(A')                   % left null space: a multiple of (1, 1, -1)

%%
% The exact value of norm(A * N) depends on your computer; it is always
% tiny. null(A, 'r') gives the whole-number basis found by hand.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part3.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-3.html#sec-solutions-fundamental-subspaces

%% Exercise 7
% Make a random 5 × 8 matrix of rank 3 as the product of a random 5 × 3 and
% a random 3 × 8 matrix. Check numerically that the dimensions of its four
% subspaces are as the table predicts, and that every null space vector is
% perpendicular to every row.

% Your code here
