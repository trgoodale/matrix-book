R = @(theta) [cosd(theta) -sind(theta);
              sind(theta)  cosd(theta)];   % rotation by theta degrees

norm(R(25)*R(50) - R(75)) < 1e-12           % rotations add
norm(R(60)^6 - eye(2)) < 1e-12

S = [2 0; 0 1];
X = [1 0; 0 -1];
M = X * R(90) * S                           % S first, then R, then X
M * [1; 1]
