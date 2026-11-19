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
