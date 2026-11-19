A = [-2 1; 1 -2];
x0 = [3; 1];
expm(A * 1) * x0           % x(1) for Example 1

% Example 2: the damped spring, solved numerically
S = [0 1; -5 -2];
opts = odeset('RelTol', 1e-10, 'AbsTol', 1e-12);
[t, x] = ode45(@(t, x) S * x, [0 2], [1; 0], opts);
x(end, :)                  % position and velocity at t = 2
exp(-2) * (cos(4) + 0.5 * sin(4))   % exact position
eig(S)                     % -1 + 2i and -1 - 2i
