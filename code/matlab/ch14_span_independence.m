%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 14: Span and linear independence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-3/14-span-independence.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% Both tests come down to rank. To find a dependence relation, find the
% solutions of Ac = 0: SciPy's null_space and MATLAB's null do this. They
% return a vector of length 1, so divide by one of its entries to get tidier
% numbers.

v1 = [1; 0; 1]; v2 = [2; 1; 0]; v3 = [0; 1; -2];
A = [v1 v2 v3];            % the vectors as columns
rank(A)                    % 2 < 3, so dependent

c = null(A);               % solutions of A c = 0
c = c / c(3)               % scaled so that c3 = 1

b = [1; 2; 3];             % is b in the span?
[rank(A), rank([A b])]

%%
% The rank is 2, so the three vectors are dependent, with 2v_1 - v_2 + v_3 =
% 0 as in Example 2. Adding b raises the rank to 3, so b is not in their
% span. In MATLAB, null(A, 'r') gives tidy whole-number answers directly.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part3.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-3.html#sec-solutions-span-independence

%% Exercise 7
% Show that the four vectors (1, 2, 0)^T, (0, 1, 1)^T, (1, 0, 1)^T and (2,
% 3, 2)^T are dependent, and find a dependence relation. Are the first three
% independent?

% Your code here
