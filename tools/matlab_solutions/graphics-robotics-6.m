L1 = 1.5; L2 = 1.0;
t1 = 0:360;
figure; hold on
for t2 = [60 120]
    x = L1 * cosd(t1) + L2 * cosd(t1 + t2);
    y = L1 * sind(t1) + L2 * sind(t1 + t2);
    plot(x, y, 'DisplayName', sprintf('theta_2 = %d', t2))
end
[T1, T2] = meshgrid(0:4:360);
scatter(L1*cosd(T1(:)) + L2*cosd(T1(:) + T2(:)), L1*sind(T1(:)) + L2*sind(T1(:) + T2(:)), 1, [0.7 0.7 0.7], ...
        'DisplayName', 'reachable')
axis equal; legend show; hold off
