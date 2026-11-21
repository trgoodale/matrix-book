%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 15: Basis, dimension and change of basis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-3/15-basis-change.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% Coordinates come from solving Pc = v, and the change of basis from solving
% PB = AP. As usual, it is better to solve than to compute P^-1 (Chapter 7).

P = [1 1; 1 -1];           % basis vectors as columns
v = [5; 1];
c = P \ v                  % coordinates of v (Example 2)

A = [3 1; 2 2];
P = [1 1; 1 -2];
B = P \ (A * P)            % P^(-1) A P (Example 4)

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part3.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-3.html#sec-solutions-basis-change

%% Exercise 7
% In Chapter 9 you found that C = [0 0 1; 1 0 0; 0 1 0] is the rotation by
% 120° about the line through (1, 1, 1). Build it the other way, by a change
% of basis. Use p = (1/sqrt(2))(1, -1, 0)^T, q = (1/sqrt(6))(1, 1, -2)^T and
% u = (1/sqrt(3))(1, 1, 1)^T as the columns of P, so that the axis u plays
% the part of the z-axis. Compute P R_z(120°) P^-1 and compare it with C.
% (These three vectors are perpendicular unit vectors, so P is orthogonal
% and P^-1 = P^T.)

% Your code here
