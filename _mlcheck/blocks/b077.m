data = readmatrix('../data/iris.csv');   % the species column is read as NaN
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
