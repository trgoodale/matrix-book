Ab = [ 1  2 -1  3  4;
       2  4 -1  7  9;
      -1 -2  2 -2 -3];      % Example 1
rref(Ab)
[rank(Ab(:, 1:4)), rank(Ab)]

A2 = [1 1 0; 1 2 1; 0 1 2]; % Example 2
rref([A2 eye(3)])           % the right half is the inverse
