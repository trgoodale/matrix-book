links = {2, [1 3], 1, [3 5], 4};    % page j links to the pages in links{j}
n = 5;  d = 0.85;
M = zeros(n);
for j = 1:n
    M(links{j}, j) = 1 / numel(links{j});
end
x = ones(n, 1) / n;
for k = 1:1000
    x_new = d*M*x + (1 - d)/n;
    if norm(x_new - x, 1) < 1e-10, break, end
    x = x_new;
end
x = x_new;
fprintf('%d iterations\n', k)
fprintf('%.4f ', x); fprintf('\n')
y = (eye(n) - d*M) \ ((1 - d)/n * ones(n, 1));
fprintf('%.4f ', y); fprintf('\n')
