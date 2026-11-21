rng(1);
h = 170 + 10 * randn(200, 1);          % heights in cm
s = h + 4 * randn(200, 1);             % arm spans in cm
X = [h, s];
Xc = X - mean(X);
[~, S, V] = svd(Xc, 'econ');
V                                      % columns are the principal components
diag(S).^2 / sum(diag(S).^2)           % fraction of variance explained
