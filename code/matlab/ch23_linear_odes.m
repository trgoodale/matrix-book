%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 23: Linear ODE systems and the matrix exponential
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-4/23-linear-odes.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% SciPy's expm and MATLAB's expm compute the matrix exponential directly,
% without needing eigenvectors, and work for any square matrix. For systems
% that are not linear, or not constant in time, numerical solvers such as
% solve_ivp and ode45 step the solution forward in time; they are worth
% trying on linear systems too, where you can check their answers.

A = [-2 1; 1 -2];
x0 = [3; 1];
expm(A * 1) * x0           % x(1) for Example 1

% Example 2: the damped spring, solved numerically
S = [0 1; -5 -2];
opts = odeset('RelTol', 1e-10, 'AbsTol', 1e-12);
[t, x] = ode45(@(t, x) S * x, [0 2], [1; 0], opts);
x(end, :)                  % position and velocity at t = 2
exp(-2) * (cos(4) + 0.5 * sin(4))   % exact position
eig(S)                     % -1 + 2i and -1 - 2i

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part4.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-4.html#sec-solutions-linear-odes

%% Exercise 7
% A dose of 100 mg of a drug is swallowed. The amount x_1 in the gut and x_2
% in the blood obey
% dotx_1 = -0.5x_1,
%
% dotx_2 = 0.5x_1 - 0.2x_2,
% with time in hours. Use the matrix exponential to compute x(t) for 0 ≤ t ≤
% 20, plot both amounts, and find when the amount in the blood is greatest
% and what it is. Check against the exact answer from the eigenvalues.

% Your code here
