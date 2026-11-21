%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 20: Symmetric and positive definite matrices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-4/20-symmetric-matrices.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% For symmetric matrices, use np.linalg.eigh rather than eig. It is faster,
% guarantees real eigenvalues (in increasing order) and orthonormal
% eigenvectors, and is not upset by tiny rounding errors that make a matrix
% very slightly unsymmetric. MATLAB's eig detects symmetric matrices itself.
% Cholesky factorisation fails, with an error, exactly when a matrix is not
% positive definite, which makes it the standard test. Note that MATLAB's
% chol returns the upper triangular factor R = L^T.

A = [5 2; 2 2];
[Q, L] = eig(A)            % eigenvalues in increasing order for a symmetric matrix

B = [4 2 2; 2 5 3; 2 3 6];
R = chol(B)                % upper triangular, with B = R' * R (so R = L')

[~, p] = chol([1 2; 2 1]);
p                          % p > 0 means "not positive definite"

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part4.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-4.html#sec-solutions-symmetric-matrices

%% Exercise 7
% At a point inside a machine part, the stress matrix in MPa is
% σ = [80 20 0; 20 40 -10; 0 -10 -30].
% Find the principal stresses and the direction of the largest one. Check
% that the principal directions are perpendicular.

% Your code here
