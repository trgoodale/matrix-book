%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 40: Vibrations and normal modes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/40-vibrations.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% scipy.linalg.eigh and MATLAB's eig both solve the generalised problem Kv =
% λMv directly, when given both matrices.

% Example 3: the two-storey building
K = 1e6 * [12 -4; -4 4];
M = 1e4 * diag([2 1]);
[V, L] = eig(K, M);            % solves K v = lambda M v
omega = sqrt(diag(L));
V = V ./ V(1, :);              % scale each mode so that its first entry is 1
fprintf('omega = %.4f rad/s, f = %.4f Hz, mode (1, %.4f)\n', [omega'; omega'/(2*pi); V(2, :)])

% Example 4: amplitudes when mass 1 is shaken
K1 = [200 -100; -100 200];
for Om = [5 10.5 sqrt(200) 20]
    X = (K1 - Om^2 * eye(2)) \ [1; 0];
    fprintf('%6.2f  %9.4f %9.4f\n', Om, X)
end

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-vibrations

%% Exercise 7
% For n equal masses m joined by n + 1 equal springs k between two walls,
% the natural frequencies are
% ω_j = 2sqrt(k/m) sin(jπ/2(n + 1)),
% j = 1, ..., n.
% Check this numerically for n = 10, m = 1 and k = 100. Plot the first three
% mode shapes for n = 30. What shapes are they, and what physical object
% does a long chain of masses and springs approximate?

% Your code here
