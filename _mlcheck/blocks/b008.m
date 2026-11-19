Rx = @(t) [1 0 0; 0 cosd(t) -sind(t); 0 sind(t) cosd(t)];
Ry = @(t) [cosd(t) 0 sind(t); 0 1 0; -sind(t) 0 cosd(t)];
Rz = @(t) [cosd(t) -sind(t) 0; sind(t) cosd(t) 0; 0 0 1];

R1 = Rz(30) * Ry(10) * Rx(5);
R2 = Rx(5) * Ry(10) * Rz(30);
M = R1' * R2;
fprintf('The two orientations differ by %.2f degrees\n', acosd((trace(M) - 1) / 2));
