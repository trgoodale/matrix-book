%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 12: Gauss–Jordan elimination and rank
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-2/12-gauss-jordan-rank.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% MATLAB has rref built in. NumPy doesn't, because computers rarely need the
% reduced form (elimination and back substitution is cheaper), but a short
% function does it. It chooses the largest available entry as each pivot,
% which keeps rounding errors small (the chapter), and treats tiny numbers
% as zero.

Ab = [ 1  2 -1  3  4;
       2  4 -1  7  9;
      -1 -2  2 -2 -3];      % Example 2
rref(Ab)
[rank(Ab(:, 1:4)), rank(Ab)]

A2 = [1 1 0; 1 2 1; 0 1 2]; % Example 4
rref([A2 eye(3)])           % the right half is the inverse

%%
% rank uses the singular value decomposition (the chapter), which is more
% reliable than counting pivots when the numbers have rounding errors. For
% exact fractions in the output, use rats(rref(Ab)).

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part2.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-2.html#sec-solutions-gauss-jordan-rank

%% Exercise 8
% In photosynthesis, plants turn carbon dioxide and water into glucose and
% oxygen: a CO_2 + b H_2O → c C_6H_12O_6 + d O_2. Write the atom balances
% for carbon, hydrogen and oxygen as a homogeneous system (as in Example 3),
% find its reduced row echelon form with code, and use it to balance the
% equation with the smallest whole numbers.

% Your code here
