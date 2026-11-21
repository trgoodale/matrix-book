%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 18: Eigenvalues and eigenvectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-4/18-eigenvalues.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% np.linalg.eig and MATLAB's eig return the eigenvalues, and the
% eigenvectors as the columns of a matrix in the same order, each scaled to
% length 1. They don't use the characteristic polynomial, which would be
% slow and inaccurate for large matrices. Instead they use the QR algorithm
% of Chapter 29. The order of the eigenvalues, and the sign of each
% eigenvector, may differ from a hand calculation.

A = [4 1; 2 3];
[V, D] = eig(A)            % eigenvectors in the columns of V, eigenvalues on the diagonal of D

eig([1 -1; 1 1])           % complex: 1 + i and 1 - i

%%
% The columns of V are (1, 1)^T and (1, -2)^T scaled to length 1, with the
% second multiplied by -1. Either sign describes the same direction.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part4.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-4.html#sec-solutions-eigenvalues

%% Exercise 7
% Three equal masses are joined in a line by four equal springs, with the
% outer springs fixed to walls. Their vibrations are governed by the matrix
% K = [2 -1 0; -1 2 -1; 0 -1 2]: the natural frequencies are proportional to
% the square roots of its eigenvalues, and the eigenvectors are the mode
% shapes, the patterns in which the masses move together. Find the
% eigenvalues and eigenvectors, and describe each mode shape in words.

% Your code here
