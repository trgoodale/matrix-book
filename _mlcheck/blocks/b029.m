P = [0 0; 4 0; 8 0; 12 0; 16 0; 4 4; 8 4; 12 4];
members = [1 2; 2 3; 3 4; 4 5; 6 7; 7 8; 2 6; 3 7; 4 8; 1 6; 5 8; 6 3; 8 3];
supports = [1 2; 5 1];
F = zeros(3, size(members, 1));
for k = 1:3
    [A, b] = truss(P, members, supports, [k+1 0 -20]);
    f = A \ b;
    F(k, :) = f(1:size(members, 1))';
end
[max(F, [], 1); min(F, [], 1)]'      % largest and smallest force in each member
% (uses the function truss from the chapter)
