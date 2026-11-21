%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 17: Orthogonality and least squares
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-3/17-orthogonality-least-squares.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% For least squares, use a solver that works on A directly rather than
% forming A^T A: NumPy's lstsq, or MATLAB's backslash, which automatically
% gives the least-squares solution when A has more rows than columns. They
% use the QR factorisation, which is more accurate (the chapter). For
% fitting polynomials there is also polyfit, which lists the coefficients
% from the highest power down.

t = [0; 1; 2; 3];
y = [1; 2; 4; 5];
A = [ones(4, 1), t];       % columns: 1 and t

x = A \ y                  % least squares, because A is tall
sum((y - A*x).^2)          % the sum of squared errors
p = polyfit(t, y, 1)       % slope first, then intercept

[Q, R] = qr([1 1; 1 0; 0 1], 0);
Q                          % orthonormal columns (Example 3, up to sign)

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part3.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-3.html#sec-solutions-orthogonality-least-squares

%% Exercise 7
% A ball is thrown upwards, and its height h in metres is measured at times
% t = 0, 0.5, 1, 1.5, 2, 2.5 seconds as 2.1, 7.6, 11.3, 11.8, 10.5, 6.2. Fit
% the model h = c_0 + c_1t + c_2t^2 by least squares. Since h = h_0 + ut -
% (1/2)gt^2 for a ball thrown up with speed u, use your fit to estimate g,
% the acceleration due to gravity.

% Your code here
