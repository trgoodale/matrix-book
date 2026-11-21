%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 24: Floating point and conditioning
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-5/24-floating-point-conditioning.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% np.linalg.norm(x, p) and np.linalg.cond(A, p) compute norms and condition
% numbers, with p equal to 1, 2 (the default) or np.inf; in MATLAB they are
% norm(x, p) and cond(A, p). Computing κ exactly needs A^-1 or the SVD,
% which costs more than solving the system, so solvers estimate it cheaply
% instead: MATLAB's rcond gives an estimate of 1/κ_1, and MATLAB warns you
% when it is close to varepsilon.

0.1 + 0.2 == 0.3
eps

x = 1e-8;
[(1 - cos(x)) / x^2, 2 * sin(x/2)^2 / x^2]   % cancellation

A = [1 1; 1 1.01];
[cond(A, inf), cond(A)]

for n = [4 8 12]
    H = hilb(n);
    xtrue = ones(n, 1);
    xhat = H \ (H * xtrue);
    fprintf('n = %2d: cond = %.1e, error = %.1e\n', n, cond(H), norm(xhat - xtrue, inf));
end

%%
% The errors depend on exactly how the solver orders its operations, so they
% vary a little between versions and computers, but their sizes don't.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part5.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-5.html#sec-solutions-floating-point-conditioning

%% Exercise 7
% For the Hilbert matrices with n = 2, 3, ..., 14, compute κ_2(H_n) and the
% error in solving H_nx = H_n1. Plot both on a logarithmic scale against n,
% and check the rule of thumb. Roughly how fast does κ grow with n?

% Your code here
