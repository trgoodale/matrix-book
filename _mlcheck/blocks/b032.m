A = [2 1;
     1 3];
x = [1; 2];
y = A * x                % matrix times vector

figure
quiver(0, 0, x(1), x(2), 0, 'Color', [0.5 0.5 0.5]); hold on
quiver(0, 0, y(1), y(2), 0, 'b')
axis equal; grid on; xlim([-1 8]); ylim([-1 8])
legend('x', 'Ax')
