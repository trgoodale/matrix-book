%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 29: Eigenvalue algorithms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-5/29-eigenvalue-algorithms.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% For large sparse matrices, when only a few eigenvalues are needed, use
% scipy.sparse.linalg.eigs (or eigsh for symmetric matrices) in Python and
% eigs in MATLAB. They use Krylov methods, Lanczos and Arnoldi, which
% extract far more from the sequence q, Aq, A^2q, ... than the power method
% does, and with the option sigma they use shifted inverse iteration to find
% the eigenvalues nearest a given value.

A = [2 1; 1 3];

% Power method
q = [1; 0];
for k = 1:5
    y = A * q;
    q = y / norm(y);
    fprintf('%d  %.10f\n', k, q' * A * q);   % Rayleigh quotient
end

% Shifted inverse iteration: factorise once, solve at each step
[L, U, P] = lu(A - 1 * eye(2));
q = [1; 0];
for k = 1:4
    y = U \ (L \ (P * q));
    q = y / norm(y);
    fprintf('%d  %.10f\n', k, q' * A * q);
end

% Basic QR algorithm
Ak = A;
for k = 1:5
    [Q, R] = qr(Ak);
    Ak = R * Q;
end
Ak

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part5.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-5.html#sec-solutions-eigenvalue-algorithms

%% Exercise 7
% Build the n × n matrix with 2 on the diagonal and -1 beside it, for n =
% 1000, as a sparse matrix. Use eigsh (Python) or eigs (MATLAB) to find its
% 5 smallest eigenvalues, and compare them with the exact values 2 -
% 2cos(kπ/(n + 1)), k = 1, ..., 5. Then try the power method on it: how many
% steps would it need to separate the two largest eigenvalues?

% Your code here
