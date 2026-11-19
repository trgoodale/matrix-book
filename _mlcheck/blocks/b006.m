for n = [2 5 10 20 50]
    d = zeros(200, 1);
    for k = 1:200
        d(k) = abs(det(2*rand(n) - 1));
    end
    fprintf('n = %2d: median |det| = %.3g\n', n, median(d));
end
