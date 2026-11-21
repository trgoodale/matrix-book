%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part VI: Applications: review
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code exercises of the part review from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/review.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

% Worked solutions are in solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-review-6

%% Exercise 11
% Five web pages link as follows: A links to B; B links to A and C; C links
% to A; D links to C and E; E links to D. Find the PageRank with damping d =
% 0.85 by the power method, counting the iterations needed, and check it by
% solving a linear system. Explain why D and E rank lowest, even though they
% link to each other.

% Your code here
