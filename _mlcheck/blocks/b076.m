A = [0 0 0 0 127 4 80;
     0.6747 0.7370 0 0 0 0 0;
     0 0.0486 0.6610 0 0 0 0;
     0 0 0.0147 0.6907 0 0 0;
     0 0 0 0.0518 0 0 0;
     0 0 0 0 0.8091 0 0;
     0 0 0 0 0 0.8091 0.8089];
[V, D] = eig(A);
[lambda, k] = max(real(diag(D)));
lambda
w = real(V(:, k)); w = w / sum(w);   % stable stage distribution
stable_percent = round(1000 * w') / 10

B = A; B(2, 1) = 1;                  % every egg survives its first year
max(real(eig(B)))
