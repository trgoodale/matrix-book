P = [0 1 1 0;           % x-coordinates of the corners
     0 0 1 1];          % y-coordinates
A = [1 0.5;
     0 1];              % shear, factor 0.5
Q = A * P               % transform every corner at once

figure
fill(P(1,:), P(2,:), 'w', 'LineStyle', '--'); hold on
fill(Q(1,:), Q(2,:), [0.6 0.8 0.75], 'FaceAlpha', 0.5)
axis equal; grid on
