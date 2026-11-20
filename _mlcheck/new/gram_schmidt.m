function Q = gram_schmidt(A)
    Q = zeros(size(A));
    for j = 1:size(A, 2)
        v = A(:, j) - Q(:, 1:j-1) * (Q(:, 1:j-1)' * A(:, j));   % remove projections
        Q(:, j) = v / norm(v);
    end
end
