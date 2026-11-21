%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 1: What is a matrix?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-1/01-matrices.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% Both languages store matrices as arrays. The main trap is indexing: Python
% counts from 0 and MATLAB counts from 1, so the entry a_23 is A[1, 2] in
% Python and A(2,3) in MATLAB.

% Temperature readings: rows are times, columns are sensors
T = [18.2 19.1 17.6;
     19.5 20.3 18.4;
     21.0 21.8 19.9;
     22.4 23.0 21.2];

size(T)        % rows, columns
T(2,3)         % row 2, column 3
T(:,1)         % all of column 1: sensor 1
T'             % the transpose

%%
% To check whether a matrix is symmetric, compare it with its transpose:

A = [1 4 5; 4 2 6; 5 6 3];
isequal(A, A')

%%
% In MATLAB, A' is the transpose for real matrices. For complex matrices it
% also takes complex conjugates; use A.' for the plain transpose.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part1.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-1.html#sec-solutions-matrices

%% Exercise 6
% Create the 6 × 6 matrix with entries a_ij = 1/(i + j - 1), and check that
% it is symmetric. (It is called the Hilbert matrix, and it returns in the
% chapter as a famously difficult matrix for computers.) In Python you may
% find np.fromfunction useful; in MATLAB, try hilb(6) and compare.

% Your code here
