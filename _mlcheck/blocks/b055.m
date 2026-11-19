P = [1 1; 1 -1];           % basis vectors as columns
v = [5; 1];
c = P \ v                  % coordinates of v (Example 1)

A = [3 1; 2 2];
P = [1 1; 1 -2];
B = P \ (A * P)            % P^(-1) A P (Example 4)
