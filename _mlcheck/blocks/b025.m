ns = [500 1000 2000 4000];
tdense = zeros(size(ns)); tsparse = zeros(size(ns));
for k = 1:numel(ns)
    n = ns(k);
    e = ones(n, 1);
    A = spdiags([-e 2*e -e], -1:1, n, n);
    Ad = full(A);
    b = ones(n, 1);
    tic; x = Ad \ b; tdense(k) = toc;
    tic; x = A \ b; tsparse(k) = toc;
end
pd = polyfit(log(ns), log(tdense), 1);
ps = polyfit(log(ns), log(tsparse), 1);
fprintf('dense grows like n^%.1f, sparse like n^%.1f\n', pd(1), ps(1));
