sigma = [80 20 0; 20 40 -10; 0 -10 -30];
[Q, D] = eig(sigma);
diag(D)                    % principal stresses, smallest first
Q(:, 3)                    % direction of the largest
Q' * Q                     % the identity, so Q is orthogonal
