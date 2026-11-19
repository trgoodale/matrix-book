P = [0 0; 4 0; 2 2];                 % joints (numbered from 1)
members = [1 2; 1 3; 2 3];
supports = [1 2; 2 1];               % joint, then 2 for a pin or 1 for a roller
loads = [3 0 -10];                   % joint, fx, fy
[A, b] = truss(P, members, supports, loads);
f = A \ b

function [A, b] = truss(P, members, supports, loads)
% Equilibrium matrix A and right-hand side for a pin-jointed truss.
% Unknowns: member forces (tension positive), then reactions.
nj = size(P, 1); nm = size(members, 1);
reac = [];
for s = 1:size(supports, 1)
    j = supports(s, 1);
    if supports(s, 2) == 2, reac = [reac; j 1; j 2]; else, reac = [reac; j 2]; end
end
A = zeros(2*nj, nm + size(reac, 1));
for k = 1:nm
    i = members(k, 1); j = members(k, 2);
    e = (P(j,:) - P(i,:)) / norm(P(j,:) - P(i,:));
    A(2*i-1:2*i, k) = A(2*i-1:2*i, k) + e';   % member pulls joint i towards j
    A(2*j-1:2*j, k) = A(2*j-1:2*j, k) - e';   % and joint j towards i
end
for r = 1:size(reac, 1)
    A(2*reac(r,1) - 2 + reac(r,2), nm + r) = 1;
end
b = zeros(2*nj, 1);
for l = 1:size(loads, 1)
    b(2*loads(l,1)-1:2*loads(l,1)) = -loads(l, 2:3)';
end
end
