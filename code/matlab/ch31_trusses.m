%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 31: Structures: pin-jointed trusses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/31-trusses.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% The function below builds the equilibrium matrix from lists of joints,
% members and supports, following the model above, and solves it. For the
% Pratt bridge it prints the force in each member with the 20 kN load at the
% middle of the span.

P = [0 0; 4 0; 2 2];                 % joints (numbered from 1)
members = [1 2; 1 3; 2 3];
supports = [1 2; 2 1];               % joint, then 2 for a pin or 1 for a roller
loads = [3 0 -10];                   % joint, fx, fy
[A, b] = truss(P, members, supports, loads);
f = A \ b

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-trusses

%% Exercise 7
% For the Pratt bridge, move a 20 kN load to each of the three interior
% joints of the bottom chord in turn. For each member, find the largest
% tension and the largest compression it ever carries. Which members must be
% designed for both?

% Your code here

%% Functions
% MATLAB needs the functions used in a script to come at its end.

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
