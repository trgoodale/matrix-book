%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 41: Networks and graphs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/41-networks.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

% Example 3: the Fiedler vector
E = [1 2; 1 3; 2 3; 3 4; 4 5; 4 6; 5 6];
A = zeros(6);
A(sub2ind([6 6], E(:, 1), E(:, 2))) = 1;
A = A + A';                          % edges go both ways
L = diag(sum(A, 2)) - A;
[V, D] = eig(L);                     % eigenvalues in increasing order
lambda = round(diag(D)' * 1e4) / 1e4 + 0   % round to 4 places; + 0 turns -0 into 0
f = V(:, 2)' * sign(V(1, 2))         % the Fiedler vector, signed so node 1 is positive
groupA = find(f > 0)
groupB = find(f < 0)

% Example 4: eigenvector centrality by the power method
E = [1 2; 1 3; 1 4; 1 5; 5 6; 5 7; 6 7; 6 8];
A = zeros(8);
A(sub2ind([8 8], E(:, 1), E(:, 2))) = 1;
A = A + A';
c = ones(8, 1);
for k = 1:200
    c = A * c;
    c = c / max(c);
end
fprintf('%.2f ', c); fprintf('\n')

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-networks

%% Exercise 7
% Make a random network with two hidden communities of 50 nodes each: join
% each pair of nodes in the same community with probability 0.3, and each
% pair in different communities with probability 0.05. Find the Fiedler
% vector, split the nodes by its signs, and count how many nodes end up in
% the right group. Repeat with a between-community probability of 0.15. What
% happens, and why?

% Your code here
