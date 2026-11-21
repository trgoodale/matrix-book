%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 30: QR factorisation and stable least squares
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-5/30-qr-least-squares.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% np.linalg.qr(A) returns the reduced factorisation by default, and MATLAB's
% qr(A, 0) (or qr(A, "econ")) does the same. For least squares, use
% np.linalg.lstsq (which uses the SVD), scipy.linalg.lstsq, or MATLAB's
% backslash A \ b, which uses Householder QR for a non-square A.

t = linspace(0, 1, 50)';
for deg = [5 8 10 12]
    A = t .^ (0:deg);                 % columns 1, t, t^2, ...
    c = ones(deg + 1, 1);
    b = A * c;
    c_normal = (A' * A) \ (A' * b);
    [Q, R] = qr(A, 0);
    c_qr = R \ (Q' * b);              % R is triangular
    fprintf('degree %2d: cond(A) = %.1e, error: normal %.1e, QR %.1e\n', ...
            deg, cond(A), max(abs(c_normal - c)), max(abs(c_qr - c)));
end

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part5.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-5.html#sec-solutions-qr-least-squares

%% Exercise 7
% Implement classical and modified Gram–Schmidt. For the matrices with
% columns 1, t, ..., t^n-1 at 50 points in [0, 1], with n = 4, 6, 8, 10, 12,
% compute ||Q^T Q - I|| for both versions and for np.linalg.qr or qr, and
% plot the results against κ(A) on log scales. What do you see?

% Your code here
