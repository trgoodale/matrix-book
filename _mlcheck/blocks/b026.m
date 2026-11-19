f = @(v) [v(1)^2 + 4*v(2)^2 - 4; v(2) - sin(2*v(1))];
starts = [-2 0.5; -1 -1; -0.5 -1; 0.5 1; 1 1; 2 -0.5];
for i = 1:size(starts, 1)
    [root, steps] = newton_fd(f, starts(i, :)');
    fprintf('(%5.2f, %5.2f) -> (%9.6f, %9.6f) in %d steps\n', starts(i, :), root, steps);
end

function [x, k] = newton_fd(f, x)
for k = 1:50
    fx = f(x);
    J = zeros(numel(fx), numel(x));
    for j = 1:numel(x)
        h = 1e-7 * max(1, abs(x(j)));
        e = zeros(size(x)); e(j) = h;
        J(:, j) = (f(x + e) - fx) / h;
    end
    dx = -J \ fx;
    x = x + dx;
    if norm(dx) < 1e-12, return, end
end
end
