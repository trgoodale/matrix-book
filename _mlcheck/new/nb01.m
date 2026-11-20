% Example 3: the two-storey building
K = 1e6 * [12 -4; -4 4];
M = 1e4 * diag([2 1]);
[V, L] = eig(K, M);            % solves K v = lambda M v
omega = sqrt(diag(L));
V = V ./ V(1, :);              % scale each mode so that its first entry is 1
fprintf('omega = %.4f rad/s, f = %.4f Hz, mode (1, %.4f)\n', [omega'; omega'/(2*pi); V(2, :)])

% Example 4: amplitudes when mass 1 is shaken
K1 = [200 -100; -100 200];
for Om = [5 10.5 sqrt(200) 20]
    X = (K1 - Om^2 * eye(2)) \ [1; 0];
    fprintf('%6.2f  %9.4f %9.4f\n', Om, X)
end
