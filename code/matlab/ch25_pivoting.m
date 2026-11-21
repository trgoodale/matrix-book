%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 25: Pivoting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-5/25-pivoting.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% Adding partial pivoting to the elimination function from Chapter 11 takes
% three lines: find the row with the largest entry in the pivot column, and
% swap it into place, in both A and b.

A = [1e-20 1; 1 1];
b = [1; 2];
x_naive = solve_ge(A, b, false)    % wrong: [0; 1]
x_pivot = solve_ge(A, b, true)     % right: [1; 1]

A = [1 2 1; 2 6 1; 4 8 6];
[L, U, P] = lu(A)                  % P*A = L*U

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part5.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-5.html#sec-solutions-pivoting

%% Exercise 7
% Build Wilkinson's matrix for n = 10, 30 and 60, choose a random x, set b =
% Wx, and solve with np.linalg.solve or backslash. Compare the relative
% error with the condition number of W, and with the largest entry of U.
% What do you conclude?

% Your code here

%% Functions
% MATLAB needs the functions used in a script to come at its end.

function x = solve_ge(A, b, pivot)
% Solve Ax = b by Gaussian elimination, with or without partial pivoting.
n = length(b);
for k = 1:n-1
    if pivot
        [~, p] = max(abs(A(k:n, k)));   % row of the largest entry
        p = p + k - 1;
        A([k p], :) = A([p k], :);      % swap rows k and p
        b([k p]) = b([p k]);
    end
    for i = k+1:n
        m = A(i,k) / A(k,k);
        A(i,k:n) = A(i,k:n) - m * A(k,k:n);
        b(i) = b(i) - m * b(k);
    end
end
x = zeros(n,1);
for i = n:-1:1
    x(i) = (b(i) - A(i,i+1:n) * x(i+1:n)) / A(i,i);
end
end
