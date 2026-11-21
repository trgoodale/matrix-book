%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 36: Population models
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/36-population-models.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

A = [0 0 0 0 127 4 80;
     0.6747 0.7370 0 0 0 0 0;
     0 0.0486 0.6610 0 0 0 0;
     0 0 0.0147 0.6907 0 0 0;
     0 0 0 0.0518 0 0 0;
     0 0 0 0 0.8091 0 0;
     0 0 0 0 0 0.8091 0.8089];
[V, D] = eig(A);
[lambda, k] = max(real(diag(D)));
lambda
w = real(V(:, k)); w = w / sum(w);   % stable stage distribution
stable_percent = round(1000 * w') / 10

B = A; B(2, 1) = 1;                  % every egg survives its first year
max(real(eig(B)))

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-population-models

%% Exercise 6
% For the loggerhead model, project the population for 100 years from 1000
% eggs and hatchlings and nothing else. Plot the total population on a
% logarithmic scale. After the first few decades, what is its slope, and how
% does it relate to λ? How many years does it take for the proportion in
% each stage to come within 1% of the stable distribution?

% Your code here
