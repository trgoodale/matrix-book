M = [2 1; 1 3];
x = [3; 2];
M * x
x(1)*M(:,1) + x(2)*M(:,2)   % 3 x column 1 + 2 x column 2
