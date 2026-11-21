%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 21: The singular value decomposition and PCA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-4/21-svd-pca.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% np.linalg.svd returns U, the singular values as a list, and V^T (not V).
% MATLAB's svd returns U, Σ and V. With full_matrices=False, or 'econ' in
% MATLAB, a tall matrix gets only the columns of U that matter, which saves
% a lot of memory for data sets.

A = [3 0; 4 5];
[U, S, V] = svd(A)         % columns of V are v1 and v2 (signs may differ)

% PCA of Example 3
X = [1 2; 2 3; 3 5; 4 4; 5 6];
Xc = X - mean(X);          % centre each column
[~, S2, V2] = svd(Xc, 'econ');
V2(:, 1)                   % first principal component
explained = diag(S2).^2 / sum(diag(S2).^2)

%%
% Software may return any singular vector multiplied by -1, as long as its
% partner is too: u_i and v_i always change sign together. The Statistics
% and Machine Learning Toolbox also has a pca function, which centres the
% data and returns the components and explained variances directly.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part4.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-4.html#sec-solutions-svd-pca

%% Exercise 7
% Generate data for 200 people with two closely related measurements, for
% example with rng = np.random.default_rng(1), h = rng.normal(170, 10, 200)
% (heights in cm) and s = h + rng.normal(0, 4, 200) (arm spans in cm). Find
% the principal components and the fraction of the variance explained by
% each, and interpret the first component.

% Your code here
