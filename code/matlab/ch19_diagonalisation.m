%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 19: Diagonalisation and matrix powers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-4/19-diagonalisation.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% The diagonalisation comes straight from eig. For powers with a specific k,
% matrix_power (or A^k in MATLAB) multiplies efficiently by repeated
% squaring; the formula eq-powers is most useful for understanding.

A = [4 1; 2 3];
[P, D] = eig(A);
norm(A - P*D/P)            % zero, up to rounding: A = P D P^(-1)

k = 5;
A^k
round(P * D^k / P)         % the same, from the eigenvalues

F = [1 1; 1 0];
F30 = F^30;
F30(1, 2)                  % the 30th Fibonacci number

%%
% P*D/P means PDP^-1: MATLAB's / solves rather than inverting. The value of
% the first norm depends on your computer; it is always tiny.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part4.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-4.html#sec-solutions-diagonalisation

%% Exercise 7
% A Leslie matrix models a population divided into age groups. For a species
% with three age groups (young, adult, old), suppose each adult has 1.5
% young per year and each old animal 1, 60% of the young survive to become
% adults, and 70% of adults survive to become old:
% L = [0 1.5 1; 0.6 0 0; 0 0.7 0].
% Find the dominant eigenvalue and its eigenvector. What is the long-run
% growth rate of the population, and what fraction of the animals is in each
% age group in the long run? Check by applying L 50 times to a starting
% population.

% Your code here
