Rx = @(t) [1 0 0; 0 cos(t) -sin(t); 0 sin(t) cos(t)];
Rz = @(t) [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];

q = pi/2;
clean = @(X) round(X * 1e10) / 1e10;   % remove rounding errors
clean(Rz(q) * Rx(q))
clean(Rx(q) * Rz(q))

% Check that a rotation is orthogonal with determinant 1
R = Rz(q) * Rx(q);
disp(norm(R' * R - eye(3)) < 1e-12), disp(det(R))
