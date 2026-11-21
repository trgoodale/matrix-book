%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 26: Cost, banded and sparse systems
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-5/26-cost-sparse.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% SciPy's scipy.sparse module stores sparse matrices, and
% scipy.sparse.linalg.spsolve solves sparse systems. In MATLAB, sparse and
% spdiags create sparse matrices, and backslash automatically uses a sparse
% solver for them. The example solves -u'' = 1 on 0 < t < 1, with u = 0 at
% both ends, by finite differences (the chapter): n grid points give a
% tridiagonal system. Its exact solution is u = t(1 - t)/2.

n = 100000;
h = 1 / (n + 1);
e = ones(n, 1);
A = spdiags([-e 2*e -e], -1:1, n, n);   % sparse tridiagonal
b = h^2 * ones(n, 1);
u = A \ b;                               % sparse solver
t = (1:n)' * h;
max(abs(u - t .* (1 - t) / 2))           % error
nnz(A)

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part5.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-5.html#sec-solutions-cost-sparse

%% Exercise 7
% Time the solution of the tridiagonal system in the code above for n = 500,
% 1000, 2000 and 4000, using (a) a dense matrix and np.linalg.solve or
% backslash on a full matrix, (b) the sparse solver. On a log–log plot,
% estimate the power of n that each time grows like.

% Your code here
