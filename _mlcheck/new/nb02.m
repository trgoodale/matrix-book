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
