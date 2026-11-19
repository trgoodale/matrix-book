links = {[2 3], 3, [], [1 3], [4 6], [4 5]};   % 1-based page numbers
n = numel(links); d = 0.85;
x = ones(n, 1) / n;
for step = 1:200
    y = (1 - d) / n * ones(n, 1);
    for j = 1:n
        if isempty(links{j})
            y = y + d * x(j) / n;           % dead end: jump anywhere
        else
            y(links{j}) = y(links{j}) + d * x(j) / numel(links{j});
        end
    end
    x = y;
end
round(x', 3)
