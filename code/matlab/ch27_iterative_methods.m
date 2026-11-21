%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 27: Iterative methods
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-5/27-iterative-methods.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% Jacobi and Gauss–Seidel take only a few lines. For real problems, use the
% library Krylov solvers: scipy.sparse.linalg.cg and gmres in Python, pcg
% and gmres in MATLAB.

n = 50;
A = 2*eye(n) - diag(ones(n-1,1), 1) - diag(ones(n-1,1), -1);
b = ones(n, 1) / (n + 1)^2;
D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);

rho = max(abs(eig(D \ (L + U))));
w = 2 / (1 + sqrt(1 - rho^2));
names = {'Jacobi', 'Gauss-Seidel', 'SOR'};
M = {D, D + L, D/w + L};
N = {L + U, U, U + (1 - 1/w)*D};

for m = 1:3
    x = zeros(n, 1);
    k = 0;
    while norm(b - A*x) >= 1e-6 * norm(b)
        x = M{m} \ (b - N{m}*x);       % M is diagonal or triangular
        k = k + 1;
    end
    fprintf('%-13s %5d steps\n', names{m}, k);
end

[x, flag, relres, iters] = pcg(A, b, 1e-6, 100);
fprintf('%-13s %5d steps\n', 'CG', iters);

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part5.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-5.html#sec-solutions-iterative-methods

%% Exercise 7
% Modify the code above to compare Jacobi, Gauss–Seidel, best SOR and CG for
% n = 25, 50, 100 and 200. How does the number of steps grow with n for each
% method? Plot the residual against the step number for n = 100 on a
% logarithmic scale.

% Your code here
