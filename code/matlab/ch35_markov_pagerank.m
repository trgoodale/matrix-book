%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 35: Markov chains and PageRank
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/35-markov-pagerank.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

% Example 1: the steady state of the weather
M = [0.7 0.3 0.2; 0.2 0.4 0.3; 0.1 0.3 0.5];
[V, D] = eig(M);
[~, k] = max(real(diag(D)));          % the eigenvalue 1
steady = V(:, k) / sum(V(:, k))       % scale to add to 1

% Example 2: PageRank by the power method
L = [0 0 1 0; 1 0 0 0; 1 1 0 1; 0 0 0 0];   % L(i,j) = 1 if page j links to page i
n = 4; d = 0.85;
Mw = L ./ sum(L, 1);                  % divide each column by its number of links
x = ones(n, 1) / n;
for k = 1:100
    x = d * (Mw * x) + (1 - d) / n;
end
x

% Example 3: an absorbing chain
Q = [0.1 0 0; 0.8 0.1 0; 0 0.85 0.1];
R = [0 0 0.85; 0.1 0.05 0.05];
N = inv(eye(3) - Q);                  % the fundamental matrix
years = sum(N, 1)                     % expected years, from each starting year
outcome = R * N                       % P(graduate), P(leave), from each starting year

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-markov-pagerank

%% Exercise 6
% Write a PageRank function that handles dead ends, by treating a page with
% no links as linking to every page. Apply it to the Dead end web of the app
% (A links to B and C; B to C; C to nothing; D to A and C; E to D and F; F
% to D and E), and check your results against the app.

% Your code here
