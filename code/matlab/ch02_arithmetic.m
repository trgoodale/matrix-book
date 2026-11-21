%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 2: Adding and scaling matrices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-1/02-arithmetic.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% In both languages, +, - and multiplying by a number work entry by entry,
% just as in the mathematics.

c = [0.2; 0.15; 0.15];      % cake recipe: flour, sugar, butter (kg)
b = [0.3; 0.1; 0.2];        % biscuit recipe
3*c + 2*b                   % shopping list for 3 cakes and 2 biscuits

A = [4 -2; 1 0];
B = [2 0; -1 3];
X = (3*B - A) / 2

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part1.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-1.html#sec-solutions-arithmetic

%% Exercise 6
% The matrix T from Chapter 1 holds four hourly readings from three
% temperature sensors. Subtract each sensor's average reading from its
% column, using broadcasting, and check that each column of the result adds
% up to zero (up to rounding).

% Your code here
