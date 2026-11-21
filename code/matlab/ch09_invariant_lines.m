%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 9: Invariant points and lines
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-1/09-invariant-lines.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% To find invariant lines with a computer, ask for the eigenvalues and
% eigenvectors. Each eigenvector is a direction of an invariant line, and
% its eigenvalue is the stretch factor. Python's np.linalg.eig returns the
% eigenvalues as an array and the eigenvectors as the columns of a matrix,
% in the same order.

A = [3 1; 2 2];
[V, D] = eig(A)          % eigenvectors in the columns of V, eigenvalues on the diagonal of D
slopes = V(2, :) ./ V(1, :)

% The axis of a rotation: the invariant points, solving (C - I)x = 0
C = [0 0 1; 1 0 0; 0 1 0];
null(C - eye(3))         % a multiple of (1, 1, 1)

%%
% The directions come out with length 1, so they are multiples of (1, 1) and
% (1, -2) rather than those vectors themselves. The slopes, 1 and -2, match
% Example 3. MATLAB may list the eigenvalues in a different order, or give a
% direction as its negative; both describe the same line. null finds all the
% solutions of (C - I)x = 0 directly.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part1.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-1.html#sec-solutions-invariant-lines

%% Exercise 7
% Use eigenvalues and eigenvectors to find the invariant lines of [1 2; 3
% 2], and the stretch factor along each. Check your answer with eq-
% invariant-lines, and then with the app. What does the negative stretch
% factor mean for the points on that line?

% Your code here
