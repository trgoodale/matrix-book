A = [1 1 0; 1 0 1; 0 1 1];
Q = gram_schmidt(A)
fprintf('Q''*Q = I: %d\n', norm(Q'*Q - eye(3)) < 1e-12)
[Q2, R2] = qr(A);
fprintf('Same columns up to sign: %d\n', norm(abs(Q2) - abs(Q)) < 1e-12)
