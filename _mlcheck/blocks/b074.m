M = trans(2, 1) * rot(90) * trans(-2, -1)
M * [3; 1; 1]

% Forward kinematics of Example 4
T = rot(30) * trans(1.5, 0) * rot(60) * trans(1, 0);
hand = T(1:2, 3)

% Apply M to every corner of a house at once: corners as columns
house = [2 4 4 3 2 2; 1 1 3 4 3 1; 1 1 1 1 1 1];
moved = M * house;
plot(house(1,:), house(2,:), moved(1,:), moved(2,:)), axis equal

function M = trans(a, b)
M = [1 0 a; 0 1 b; 0 0 1];
end

function M = rot(deg)
M = [cosd(deg) -sind(deg) 0; sind(deg) cosd(deg) 0; 0 0 1];
end
