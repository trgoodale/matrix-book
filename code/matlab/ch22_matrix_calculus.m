%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 22: Derivatives with vectors and matrices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-4/22-matrix-calculus.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% Getting gradients right by hand is error-prone, so it is worth checking
% them numerically: compare each entry with a finite difference (f(x + he_i)
% - f(x - he_i))/(2h) for a small h. In Python, the SymPy package (pip
% install sympy) can also find gradients, Jacobians and Hessians
% symbolically, as can MATLAB's Symbolic Math Toolbox with gradient,
% jacobian and hessian.

A = [3 1; 1 2];
b = [5; 5];
f = @(x) 0.5 * x' * A * x - b' * x;
grad = @(x) A * x - b;

% Check the gradient by central differences
x = [-2; -1];
h = 1e-6;
E = eye(2);
fd = zeros(2, 1);
for i = 1:2
    fd(i) = (f(x + h*E(:, i)) - f(x - h*E(:, i))) / (2*h);
end
[grad(x), fd]

% Gradient descent
for k = 1:19
    x = x - 0.4 * grad(x);
end
x                          % close to (1, 2)

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part4.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-4.html#sec-solutions-matrix-calculus

%% Exercise 7
% Use gradient descent to minimise f(x) = (1/2)x^T Ax with A = [10 0; 0 1],
% starting from (1, 1), with step sizes α= 0.1, 0.18 and 0.21. For each,
% count the steps until ||x|| < 10^-6, or report that it fails. Explain the
% results using the eigenvalues of A.

% Your code here
