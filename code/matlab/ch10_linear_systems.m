%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 10: Systems of linear equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-2/10-linear-systems.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% Both languages solve square systems with one command, which uses the
% elimination method of Chapter 11. Always check the answer by multiplying
% back: the residual Ax - b should be zero, apart from tiny rounding errors.

A = [0.6 0.8 0.5;
     0.3 0.1 0.2;
     0.1 0.1 0.3];
b = [60; 22; 18];

x = A \ b
A*x - b              % the residual: zero, up to rounding

%%
% Here the residual happens to be exactly zero. On another computer it might
% be something like 1.0e-14: tiny, which is all that matters. When detA = 0,
% MATLAB still returns an answer but warns that the matrix is singular, and
% the answer is meaningless (often Inf or NaN, "not a number"). Never ignore
% that warning.
%
% To tell "no solution" from "infinitely many", compare the rank of A with
% the rank of the augmented matrix. The rank counts the genuinely
% independent equations (Chapter 12 explains it fully). If adding b
% increases the rank, b brings in an equation that contradicts the others,
% and there is no solution:

A2 = [1 1 1; 1 -1 1; 2 0 2];
b2 = [3; 1; 5];
[rank(A2), rank([A2 b2])]

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part2.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-2.html#sec-solutions-linear-systems

%% Exercise 7
% In Example 1, find the mixture for a new alloy of 100 kg containing 65 kg
% of copper, 20 kg of zinc and 15 kg of tin. Then try 55 kg of copper, 30 kg
% of zinc and 15 kg of tin. What goes wrong, and what does it mean for the
% workshop?

% Your code here
