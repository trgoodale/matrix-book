A = randn(5, 3) * randn(3, 8);
r = rank(A)
dims = [size(orth(A), 2), size(null(A), 2), size(orth(A'), 2), size(null(A'), 2)]
max(abs(A * null(A)), [], 'all')     % tiny: rows are perpendicular to the null space
