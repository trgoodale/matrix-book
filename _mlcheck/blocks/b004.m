F = [0 0.5 0.5  1.1  1.1 0.5 0.5  1.3  1.3 0;
     0 0   0.85 0.85 1.3 1.3 1.75 1.75 2.2 2.2];
figure; hold on
for k = 0:7
    R = [cosd(45*k) -sind(45*k); sind(45*k) cosd(45*k)];
    G = R * F;
    fill(G(1,:), G(2,:), rand(1,3), 'FaceAlpha', 0.25)
end
axis equal; grid on
