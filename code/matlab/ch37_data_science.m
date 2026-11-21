%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 37: Data: regression and dimensionality reduction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/37-data-science.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% Data
% The data files are in the book's repository. Use the local copy if there is
% one, otherwise read them from GitHub.
if isfile(fullfile('..', '..', 'data', 'iris.csv'))
    DATA = fullfile('..', '..', 'data');
else
    DATA = 'https://raw.githubusercontent.com/trgoodale/matrix-book/main/data';
end

%% In code

data = readmatrix([DATA '/iris.csv']);   % the species column is read as NaN
X = data(:, 1:4);
y = X(:, 1);                             % sepal length
n = size(X, 1);

% Example 2: regression, with and without collinear variables
c1 = [ones(n,1), X(:,4)] \ y
c2 = [ones(n,1), X(:,3), X(:,4)] \ y
cond([ones(n,1), X(:,3), X(:,4)])

% Example 3: PCA of the standardised measurements
Z = (X - mean(X)) ./ std(X);
[U, S, V] = svd(Z, 'econ');
explained = diag(S).^2 / sum(diag(S).^2)
V(:, 1)                                  % loadings of the first component

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-data-science

%% Exercise 6
% Fit sepal length on all three other measurements. Then refit using only
% the 50 setosa flowers. Compare the coefficients and their signs, and the
% condition numbers of the two design matrices. What does this suggest about
% fitting one model to data from several groups?

% Your code here
