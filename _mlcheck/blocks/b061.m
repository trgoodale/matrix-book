A = [3 0; 4 5];
[U, S, V] = svd(A)         % columns of V are v1 and v2 (signs may differ)

% PCA of Example 3
X = [1 2; 2 3; 3 5; 4 4; 5 6];
Xc = X - mean(X);          % centre each column
[~, S2, V2] = svd(Xc, 'econ');
V2(:, 1)                   % first principal component
explained = diag(S2).^2 / sum(diag(S2).^2)
