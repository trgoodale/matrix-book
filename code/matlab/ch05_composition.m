%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 5: Composing transformations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-1/05-composition.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

R = @(theta) [cosd(theta) -sind(theta);
              sind(theta)  cosd(theta)];   % rotation by theta degrees

norm(R(25)*R(50) - R(75)) < 1e-12           % rotations add
norm(R(60)^6 - eye(2)) < 1e-12

S = [2 0; 0 1];
X = [1 0; 0 -1];
M = X * R(90) * S                           % S first, then R, then X
M * [1; 1]

%%
% cosd and sind take angles in degrees, and give exact results for multiples
% of 90°.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part1.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-1.html#sec-solutions-composition

%% Exercise 7
% Pick two random 2 × 2 matrices and check numerically that (AB)^T = B^T
% A^T, but that AB ≠ BA. Then find, by experiment, a non-diagonal matrix
% that commutes with [2 1; 1 2].

% Your code here
