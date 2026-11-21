%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 33: Heat flow and finite differences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/33-finite-differences.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% The Kronecker product builds the plate matrix in one line. The example
% solves a 49 × 49 grid, 2401 unknowns, with a sparse direct solver and with
% conjugate gradients.

% A plate with a hot top edge
n = 49;
e = ones(n, 1);
T = spdiags([-e 2*e -e], -1:1, n, n);
I = speye(n);
A = kron(I, T) + kron(T, I);
b = zeros(n, n);
b(1, :) = 100;                       % neighbours on the hot edge
u = A \ b(:);
U = reshape(u, n, n);
size(A), nnz(A)
U((n+1)/2, (n+1)/2)                  % centre temperature

[x, flag, relres, iters] = pcg(A, b(:), 1e-8, 500);
iters                                % CG steps
imagesc(U), colorbar, axis equal tight

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-finite-differences

%% Exercise 6
% Solve the plate problem with the top at 100 °C and the other edges at 0 °C
% for n = 10, 20, 40, 80, with a sparse direct solver and with CG. Record
% the time taken and the number of CG steps. How does the number of CG steps
% grow with n? Plot the temperature along the vertical centre line for n =
% 80.

% Your code here
