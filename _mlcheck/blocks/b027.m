n = 1000;
e = ones(n, 1);
T = spdiags([-e 2*e -e], -1:1, n, n);
values = sort(eigs(T, 5, 'smallestabs'))
exact = 2 - 2 * cos((1:5)' * pi / (n + 1))
