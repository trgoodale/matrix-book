A = [2 1; 1 3];

% Power method
q = [1; 0];
for k = 1:5
    y = A * q;
    q = y / norm(y);
    fprintf('%d  %.10f\n', k, q' * A * q);   % Rayleigh quotient
end

% Shifted inverse iteration: factorise once, solve at each step
[L, U, P] = lu(A - 1 * eye(2));
q = [1; 0];
for k = 1:4
    y = U \ (L \ (P * q));
    q = y / norm(y);
    fprintf('%d  %.10f\n', k, q' * A * q);
end

% Basic QR algorithm
Ak = A;
for k = 1:5
    [Q, R] = qr(Ak);
    Ak = R * Q;
end
Ak
