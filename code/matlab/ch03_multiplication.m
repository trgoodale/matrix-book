%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 3: Matrix multiplication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-1/03-multiplication.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% This is the most common bug in numerical code, so it is worth stating
% plainly. In both languages there are two different multiplications, and
% the one that looks natural is not the same in each.
%
% | Operation | Python (NumPy) | MATLAB |
% |:--|:--:|:--:|
% | Matrix product AB | A @ B | A * B |
% | Entry-by-entry product | A  B | A . B |
% | Power A^3 | np.linalg.matrix_power(A, 3) | A^3 |
% | Entry-by-entry power | A ** 3 | A .^ 3 |

A = [1 2 3; 4 5 6];
B = [7 8; 9 10; 11 12];
A * B                    % matrix product

P = [3 1; 2 4];
Q = [1 2; 0 1];
P * Q
Q * P                    % different: order matters
P .* Q                   % entry by entry: NOT the matrix product

%%
% The column view of Ax, checked in code:

M = [2 1; 1 3];
x = [3; 2];
M * x
x(1)*M(:,1) + x(2)*M(:,2)   % 3 x column 1 + 2 x column 2

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part1.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-1.html#sec-solutions-multiplication

%% Exercise 7
% For the road network N of Example 2, compute N^3 and use it to find the
% number of three-step routes from town 1 back to town 1. List them. Why is
% the corresponding entry for town 4 zero?

% Your code here
