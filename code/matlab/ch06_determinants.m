%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 6: Determinants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-1/06-determinants.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

S = [1 2 3; 4 5 6; 7 8 9];
d = det(S)

%%
% This matrix is singular (its rows are in arithmetic progression, so row 1
% minus twice row 2 plus row 3 is zero), so its determinant should be
% exactly 0. The tiny error comes from rounding in floating-point
% arithmetic, because MATLAB computes determinants by elimination (as in
% Example 4), not by cofactors.
%
% For the same reason, never test whether a matrix is singular with det(A)
% == 0. A singular matrix may give a tiny non-zero determinant, as here, and
% a perfectly healthy matrix can have a tiny determinant just because its
% entries are small: det(0.1*eye(10)) is 10^-10. To check whether a matrix
% is close to singular, use its rank, the number of independent directions
% it keeps (3 for a healthy 3 × 3 matrix; see the chapter), or its condition
% number, which is huge for a matrix that is singular or nearly so (the
% chapter):

rank(S)          % 2, not 3: S is singular
cond(S)          % enormous: S is singular or nearly so

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part1.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-1.html#sec-solutions-determinants

%% Exercise 8
% Generate random n × n matrices with entries between -1 and 1, and record
% |detA| for n = 2, 5, 10, 20, 50. How does the typical size of the
% determinant change with n? Why is the size of a determinant a poor guide
% to whether a matrix is nearly singular?

% Your code here
