%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 7: Inverse matrices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-1/07-inverses.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

A = [4 7; 2 6];
b = [1; 2];

inv(A)          % the inverse, if you really need it
A \ b           % the right way to solve Ax = b

%%
% The difference matters for large systems. Here both approaches solve a
% random 2000 × 2000 system, and we compare the time taken and the size of
% the error, measured by how far Ax is from b:

n = 2000;
M = randn(n);
v = randn(n, 1);

tic; x1 = M \ v;      t1 = toc;
tic; x2 = inv(M) * v; t2 = toc;
fprintf('backslash: %.3f s, error %.1e\n', t1, norm(M*x1 - v));
fprintf('inv:       %.3f s, error %.1e\n', t2, norm(M*x2 - v));

%%
% Using the inverse typically takes several times as long and gives a larger
% error. MATLAB's code editor warns you when it sees inv(A)*b for this
% reason.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part1.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-1.html#sec-solutions-inverses

%% Exercise 7
% The Hill cipher is a simple secret code. It turns letters into numbers (A
% = 0, B = 1, ..., Z = 25), multiplies pairs of them by a key matrix, and
% then replaces each result by its remainder after dividing by 26 ("reducing
% modulo 26"), so that it is a letter again. With key K = [3 3; 2 5], the
% message HELP becomes the vectors (7, 4)^T and (11, 15)^T. Encrypt it. Then
% check that K^-1 modulo 26 is [15 17; 20 9], by showing that K times this
% matrix is I modulo 26, and use it to decrypt. (the chapter explains how
% this inverse is found.)

% Your code here
