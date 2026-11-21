%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 4: Matrices as transformations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-1/04-transformations.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% To transform a whole shape at once, store its points as the columns of a
% matrix. Then one multiplication moves every point, because column j of AP
% is A times column j of P.

P = [0 1 1 0;           % x-coordinates of the corners
     0 0 1 1];          % y-coordinates
A = [1 0.5;
     0 1];              % shear, factor 0.5
Q = A * P               % transform every corner at once

figure
fill(P(1,:), P(2,:), 'w', 'LineStyle', '--'); hold on
fill(Q(1,:), Q(2,:), [0.6 0.8 0.75], 'FaceAlpha', 0.5)
axis equal; grid on

%%
% The plot matches the Python version.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part1.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-1.html#sec-solutions-transformations

%% Exercise 7
% Apply the rotation R(θ) to the F shape (corner coordinates are in the code
% for Figure 4.1) for θ= 0°, 45°, 90°, ..., 315°, and plot all eight images
% on one set of axes.

% Your code here
