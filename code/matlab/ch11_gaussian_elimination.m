%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 11: Gaussian elimination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-2/11-gaussian-elimination.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% The function below follows the method exactly: a loop over pivot columns,
% an inner loop over the rows below, then back substitution. It stops with
% an error if it meets a zero pivot. the chapter adds row swaps.

A = [2 1 -1; -3 -1 2; -2 1 2];
b = [8; -11; -3];
x = gaussian_elimination(A, b)

%%
% In practice, use the backslash operator, which adds pivoting and is far
% faster:

x = A \ b

%%
% Functions defined in a script must come at the end of the file (MATLAB
% R2016b or later). You can also save the function in its own file,
% gaussian_elimination.m.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part2.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-2.html#sec-solutions-gaussian-elimination

%% Exercise 6
% Add a counter to the gaussian_elimination function that counts every
% multiplication, division, addition and subtraction. Run it on random
% systems with n = 10, 20, 40, 80, and compare the counts with (2/3)n^3.

% Your code here

%% Functions
% MATLAB needs the functions used in a script to come at its end.

function x = gaussian_elimination(A, b)
% Solve Ax = b by Gaussian elimination without pivoting.
n = length(b);

% Forward elimination
for k = 1:n-1
    if A(k,k) == 0
        error('Zero pivot in row %d: a row swap is needed', k);
    end
    for i = k+1:n
        m = A(i,k) / A(k,k);          % multiplier
        A(i,k:n) = A(i,k:n) - m * A(k,k:n);
        b(i) = b(i) - m * b(k);
    end
end

% Back substitution
x = zeros(n,1);
for i = n:-1:1
    x(i) = (b(i) - A(i,i+1:n) * x(i+1:n)) / A(i,i);
end
end
