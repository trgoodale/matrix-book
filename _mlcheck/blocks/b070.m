t = linspace(0, 1, 50)';
for deg = [5 8 10 12]
    A = t .^ (0:deg);                 % columns 1, t, t^2, ...
    c = ones(deg + 1, 1);
    b = A * c;
    c_normal = (A' * A) \ (A' * b);
    [Q, R] = qr(A, 0);
    c_qr = R \ (Q' * b);              % R is triangular
    fprintf('degree %2d: cond(A) = %.1e, error: normal %.1e, QR %.1e\n', ...
            deg, cond(A), max(abs(c_normal - c)), max(abs(c_qr - c)));
end
