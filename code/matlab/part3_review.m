%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part III: Vector spaces: review
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code exercises of the part review from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-3/review.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

% Worked solutions are in solutions_part3.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-3.html#sec-solutions-review-3

%% Exercise 8
% Write a Gram–Schmidt function that takes a matrix and returns a matrix Q
% with orthonormal columns spanning the same space. Apply it to the columns
% (1, 1, 0)^T, (1, 0, 1)^T, (0, 1, 1)^T, check that Q^T Q = I, and compare Q
% with the built-in QR factorisation.

% Your code here
