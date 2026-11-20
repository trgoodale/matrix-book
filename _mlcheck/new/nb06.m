A = [0.10 0.05 0.02; 0.20 0.35 0.10; 0.10 0.20 0.25];
L = inv(eye(3) - A);
e = [1.0 0.6 0.1];
e_new = e .* [1 0.8 1];                           % manufacturing cuts by 20%
f = e * L;  f_new = e_new * L;
fprintf('%.3f ', f); fprintf('\n')
fprintf('%.3f ', f_new); fprintf('\n')
fprintf('%.1f%% ', 100 * (f - f_new) ./ f); fprintf('lower\n')
